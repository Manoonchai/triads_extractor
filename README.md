# TriadsExtractor

## Running

```shell
# Build
mix deps.get
mix escript.build

# Run
./triads_extractor -i path/to/input.csv -o path/to/output.txt
```

## Getting Data

Scrape using [Twint](https://github.com/twintproject/twint), but since it needs keyword I have to split it to multiple processes.

1. Install Twint

   ```shell
   pip3 install --user --upgrade git+https://github.com/twintproject/twint.git@origin/master#egg=twint
   ```

2. Scrape Thai Tweets, as much as you want

   ```shell
   # Scrape by geolocation
   twint -g="13.736717,100.523186,500km" --csv -o tweet-geo-thailand.csv --lang th

   # Scrape until date
   export DATE=2020-10-02 ; twint -g="13.736717,100.523186,500km" --csv -o tweet-geo-thailand-$DATE.csv --lang th --until $DATE
   export DATE=2021-01-01 ; twint -g="13.736717,100.523186,500km" --csv -o tweet-geo-thailand-$DATE.csv --lang th --until $DATE

   # Scrape @sugree tweets!
   twint -u=sugree --csv -o tweet-sugree.csv
   ```

3. Combine & remove duplicates

   ```shell
   cat tweet-*.csv | sort -r -u > tweet-combined-uniq.csv
   ```

## TODOs

- [ ] Cleanup gibberish data
- [ ] Output as triads (json/csv) with frequencies
