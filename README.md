# Global Entry Appointment Bot

A Twitter bot that announces open Global Entry interview slots.

Based largely on [oliversong/goes-notifier](https://github.com/oliversong/goes-notifier),
[mvexel/next_global_entry](https://github.com/mvexel/next_global_entry),
and [this comment](https://github.com/oliversong/goes-notifier/issues/5#issuecomment-336966190).

This project is (obviously) not affiliated with U.S. Customs and Border Protection.

## Installation

Install dependencies with

```
pip install -r requirements.txt
```

## Usage

To check for new appointment slots, run `main.py`. The application exposes several subcommands:
```
usage: main.py [-h] [--verbose] {locations,appointments,tweet} ...

options:
  -h, --help            show this help message and exit
  --verbose, -v         Use verbose logging

subcommands:
  valid subcommands

  {locations,appointments,tweet}
                        possible subcommands
    locations           Get interview locations
    appointments        Get available appointments
    tweet               Tweet available appointments
```

### Locations

To check or tweet appointments, you must supply an integer identifier of the location you would like to check. You can get those identifiers with the `locations` subcommand, e.g.:
```
$ python main.py locations
5001	Hidalgo Enrollment Center
5002	San Diego -Otay Mesa Enrollment Center
```

### Appointments

You can check appointments with the `appointments` subcommand. It takes pairs of the form `NAME,CODE`, where `NAME` is a name chosen by the user (for human readability), and `CODE` is the identifier for the enrollment center (see `locations` subcommand). For example, LAX is `LAX,5180` and SFO is `SFO,5446`.

### Tweet

You can tweet appointments with the `tweet` subcommand. As with the `appointments` subcommand, it takes pairs of the form `NAME,CODE`. It requires twitter credentials (see below), and exposes a `-t/--test` flag to do everything but actually tweet.

#### Credentials

You will need to supply your Twitter API credentials. You can do this in two ways. The first is with environment variables:
```
CONSUMER_KEY=consumer_key CONSUMER_SECRET=consumer_secret ACCESS_TOKEN_KEY=access_token_key ACCESS_TOKEN_SECRET=access_token_secret python main.py
```

Or by providing a file with the credentials to the application using the `--credentials`/`-c` flag. The file is formatted in this way:
```
[twitter]
consumer_key = consumer_key
consumer_secret = consumer_secret
access_token_key = access_token_key
access_token_secret = access_token_secret
```

### Docker

The application can be packaged and run with docker. The image is registered at `ghcr.io/cwienberg/global-entry-bot`. The image is built on every commit or pull request to `main`, and is published on commits to `main`. Images are tagged with the git sha and the `latest` tag tracks the `main` branch.

You can also build locally with:
```
docker build -t global-entry-bot .
```

and run with e.g.

```
docker run --rm -v /host/path/to/twitter_credentials.ini:/config/twitter_credentials.ini global-entry-bot --verbose -c /config/twitter_credentials.ini SFO,5001
```

### TL;DR

Here's an example command to run the application:
```
python main.py -c /path/to/twitter/creds.ini LAX,5180
```
