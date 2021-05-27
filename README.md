# TriadsExtractor

## Running

```shell
mix deps.get
mix run
```

## Getting Data

Scrape using [Twint](https://github.com/twintproject/twint), but since it needs keyword I have to split it to multiple processes.

1. Install Twint

   ```shell
   pip3 install --user --upgrade git+https://github.com/twintproject/twint.git@origin/master#egg=twint
   ```

2. Scrape Thai Tweets, as much as you want

   ```shell
   twint -s "น" --csv -o tweet-nor.csv
   twint -s "า" --csv -o tweet-ar.csv
   twint -s "ร" --csv -o tweet-ror.csv
   twint -s "อ" --csv -o tweet-or.csv
   twint -s "่" --csv -o tweet-aek.csv
   twint -s "เ" --csv -o tweet-ae.csv
   twint -s "ว" --csv -o tweet-wor.csv
   twint -s "ง" --csv -o tweet-ngor.csv
   twint -s "ม" --csv -o tweet-mor.csv
   twint -s "ย" --csv -o tweet-yor.csv
   twint -s "ี" --csv -o tweet-ee.csv
   twint -g="13.736717,100.523186,500km" --csv -o tweet-geo-thailand.csv --lang th
   ```

3. Combine & remove duplicates

   ```shell
   cat tweet-*.csv | sort -r -u > tweet-combined-uniq.csv
   ```

## TODOs

- [ ] Cleanup gibberish data
- [ ] Output as triads (json/csv) with frequencies
