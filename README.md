# PsychonautWiki Journal Substance Injector

A browser-based tool to inject substances into [PsychonautWiki Journal](https://psychonautwiki.org/wiki/PsychonautWiki_Journal) exports, bypassing the limitation that only allows selecting your 3 most-used substances when logging.

## Why?

Later versions of the PsychonautWiki Journal app restrict substance selection to your top 3 most-used substances. This tool dynamically calculates how many entries are needed to guarantee your chosen substance reaches the top 3, then injects tagged entries into past years (starting from 2005) spread out evenly.

This project was created to protest the Journal app [abandoning its FOSS roots for proprietary monetization](https://github.com/isaakhanimann/psychonautwiki-journal-android/commit/1a194a5e6d2a878ce642fa8be711dbb8182fb699). Software handling extremely sensitive personal data should be free software.

## Features

- **100% Client-Side**: Your data never leaves your device — runs entirely in your browser
- **PWA Support**: Install as an app and use offline
- **Smart Injection**: Calculates minimum entries needed to reach top 3
- **Substance Validation**: Optional validation via PsychonautWiki API to verify substance names
- **Non-Destructive**: Fake entries are clearly tagged with `[INJECTED_BY_SUBSTANCE_INJECTOR]` and will be automatically replaced when you run the tool again
- **Transparent**: Source code is licensed under the GPLv3 and is available here.

## How to Use

1. Export your journal from the app settings (`Export File`)
2. Upload the exported `Journal.json` file
3. Select a substance from the dropdown or type a custom substance name
4. Click **Inject Substance**
5. Click **Download Modified JSON**
6. In the app, use **Delete everything** to clear your entries
7. Import the modified JSON file using **Import File**

## Privacy

This tool runs entirely in your browser. No data is ever sent to any server (except for optional substance name validation via PsychonautWiki's GraphQL API).

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
