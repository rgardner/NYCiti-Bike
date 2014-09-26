# CitiBike

Learn more about how you use the Citi Bike program. After following the getting
started instructions, create your own scripts!

## Getting Started

```sh
$ bundle install
# Edit Citi Bike username and password in config.yml
$ cp config.yml.example config.yml
$ vim config.yml
# Run basic stats reporter on your first trip page
$ ruby -Ilib ./bin/citibike -n 1
Total time:             182 minutes (3 hrs 2 mins)
Cost per minute:        $0.52
Cost per trip:          $9.50
Start Station,Start Time,End Station,End Time,Duration (seconds)
W 63 St & Broadway,2016-06-16T20:48:49+00:00,W 82 St & Central Park West,2016-06-16T21:05:15+00:00,986
Central Park West & W 85 St,2016-06-16T17:35:10+00:00,E 72 St & Park Ave,2016-06-16T17:43:12+00:00,482
Central Park West & W 85 St,2016-06-10T19:22:50+00:00,Central Park West & W 85 St,2016-06-10T19:52:59+00:00,1809
Central Park West & W 76 St,2016-05-26T16:31:04+00:00,W 84 St & Columbus Ave,2016-05-26T17:11:21+00:00,2417
Central Park West & W 85 St,2016-05-26T15:13:59+00:00,Central Park West & W 85 St,2016-05-26T15:57:56+00:00,2637
Central Park West & W 85 St,2016-05-25T21:47:59+00:00,Broadway & W 60 St,2016-05-25T21:58:34+00:00,635
Broadway & W 60 St,2016-05-25T11:09:04+00:00,Central Park West & W 85 St,2016-05-25T11:24:43+00:00,939
LaGuardia Pl & W 3 St,2016-04-15T17:55:42+00:00,Cleveland Pl & Spring St,2016-04-15T18:02:55+00:00,433
Cleveland Pl & Spring St,2016-04-14T15:05:18+00:00,Great Jones St,2016-04-14T15:08:43+00:00,205
Cleveland Pl & Spring St,2016-04-12T10:54:18+00:00,LaGuardia Pl & W 3 St,2016-04-12T11:00:51+00:00,393
```

## Testing

```sh
rake
```

## Potential Future Work

1. Create visualizations for data
   1. Effective Cost / minute
   2. Time saved given expected alternative transportation speeds
   3. Average Speed
   4. Commute Analysis (various speeds at different times in set interval)
