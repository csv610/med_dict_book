#!/usr/bin/env python3
"""Download Wikimedia Commons image matches for image_prompts.json.

Only Commons results are used, and the accompanying manifest preserves the
source, description, and license metadata needed for attribution.
"""

from __future__ import annotations

import argparse
import json
import re
import time
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import Request, urlopen


API = "https://commons.wikimedia.org/w/api.php"
IMAGE_MIMES = {"image/jpeg", "image/png", "image/gif", "image/svg+xml", "image/tiff"}


def api(params: dict) -> dict:
    query = urlencode({"format": "json", "formatversion": 2, **params})
    req = Request(f"{API}?{query}", headers={"User-Agent": "pocket-medical-dictionary/1.0"})
    with urlopen(req, timeout=30) as response:
        return json.load(response)


def safe_name(term: str) -> str:
    value = re.sub(r"[^A-Za-z0-9]+", "_", term).strip("_").lower()
    return value[:120] or "untitled"


def metadata(info: dict, key: str) -> str:
    value = info.get("extmetadata", {}).get(key, {}).get("value", "")
    return re.sub(r"<[^>]+>", "", value).strip()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=25, help="number of prompt entries to process")
    parser.add_argument("--input", default="image_prompts.json")
    parser.add_argument("--output", default="images/commons")
    args = parser.parse_args()

    entries = json.loads(Path(args.input).read_text(encoding="utf-8"))[: args.limit]
    output = Path(args.output)
    output.mkdir(parents=True, exist_ok=True)
    manifest = []

    for entry in entries:
        term = entry["medical_term"]
        record = {"medical_term": term, "status": "unavailable"}
        try:
            result = api({
                "action": "query",
                "generator": "search",
                "gsrsearch": term,
                "gsrnamespace": 6,
                "gsrlimit": 8,
                "prop": "imageinfo",
                "iiprop": "url|mime|size|extmetadata",
                "iiurlwidth": 1200,
            })
            pages = result.get("query", {}).get("pages", [])
            candidates = []
            for page in pages:
                info = (page.get("imageinfo") or [{}])[0]
                if info.get("mime") in IMAGE_MIMES and info.get("thumburl"):
                    candidates.append((page, info))
            if candidates:
                page, info = candidates[0]
                suffix = ".png" if info["mime"] == "image/svg+xml" else "." + info["mime"].split("/")[1]
                path = output / f"{safe_name(term)}{suffix}"
                with urlopen(Request(info["thumburl"], headers={"User-Agent": "pocket-medical-dictionary/1.0"}), timeout=60) as response:
                    path.write_bytes(response.read())
                record.update({
                    "status": "downloaded",
                    "file": str(path),
                    "commons_title": page.get("title"),
                    "source_url": info.get("descriptionurl"),
                    "direct_url": info.get("url"),
                    "license": metadata(info, "LicenseShortName"),
                    "artist": metadata(info, "Artist"),
                    "description": metadata(info, "ImageDescription"),
                })
        except Exception as exc:  # retain progress for individual unavailable results
            record.update({"status": "error", "error": str(exc)})
        manifest.append(record)
        print(record["status"], term)
        time.sleep(0.2)

    (output / "manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"processed={len(manifest)} downloaded={sum(x['status'] == 'downloaded' for x in manifest)}")


if __name__ == "__main__":
    main()
