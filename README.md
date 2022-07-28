# Jena Fuseki for SDBM triples

Configuration, instructions, and helper script for running SDBM triples under
Jena Fuseki using TDB2 and Fuseki2.

## Install and configure Jena and Jena Fuseki

Skip to the [Usage section](#usage) if you've already completed the installation and
configuration steps.

If you don't already have it, install the Java runtime environment (JRE) on
your computer:

- <https://www.java.com/en/download/help/download_options.html>

You must have Java 11 to run this version of Jena (4.5.0).

Note: I'm assuming the JRE will work. If it does not you may need to install the
[Java Development Kit (JDK)][JDK].

[JDK]: https://www.oracle.com/java/technologies/downloads/ "JDK downloads page"

Create a folder on your Linux/MacOS computer home directory called `Java`.

```shell
$ mkdir $HOME/Java
```

Download and unzip the these files in the new `Java directory`:

- <https://dlcdn.apache.org/jena/binaries/apache-jena-fuseki-4.5.0.zip>
- <https://dlcdn.apache.org/jena/binaries/apache-jena-4.5.0.zip>

### Configure your system to use Jena 4.5

Copy the sample configuration file, `sample.sdbmjfrc`, to `.sdbmjfrc`.

```shell
cp sample.sdbmjfrc .sdbmjfrc
```

This will be used to create the `FUSEKI_HOME` and `JENA_HOME` environment
variables and add Jena and Fuseki commands to your `PATH`. Its contents are:

```bash
export FUSEKI_HOME=$HOME/Java/apache-jena-fuseki-4.5.0
export JENA_HOME=$HOME/Java/apache-jena-4.5.0

PATH=$PATH:$FUSEKI_HOME
PATH=$PATH:$FUSEKI_HOME/bin
PATH=$PATH:$JENA_HOME/bin

export PATH
```

You will need to adjust this file if Jena and Fuseki are installed at
different locations from the one recommended here, or if you're using
a version other than 4.5.0.

### Test the setup

There are two steps here:

1. Load the test data into Jena
2. Query the data using Fuseki

#### Load the test data into Jena

NB If you already have a folder called `TDB2`, delete it and reload the `ttl`
file data. If you're loading the data, you must delete the `TDB2` folder to
avoid loading the data twice.

```bash
rm -rf TDB2
the following creates the `TDB2` folder
tdb2.tdbloader --verbose --loc TDB2 test/test.ttl
```

Run the script `start-fuseki.sh`:

```bash
./start-fuseki.sh
```

You should see something something like the following.

```shell
[2022-07-27 16:05:54] Server     INFO  Apache Jena Fuseki 4.5.0
[2022-07-27 16:05:54] Config     INFO  FUSEKI_HOME=/Users/emeryr/Java/apache-jena-fuseki-4.5.0
[2022-07-27 16:05:54] Config     INFO  FUSEKI_BASE=/Users/emeryr/code/GIT/sdbm-jena-fuseki/run
[2022-07-27 16:05:54] Config     INFO  Shiro file: file:///Users/emeryr/code/GIT/sdbm-jena-fuseki/run/shiro.ini
[2022-07-27 16:05:55] Server     INFO  Path = /tdb2-database
[2022-07-27 16:05:55] Server     INFO  System
[2022-07-27 16:05:55] Server     INFO    Memory: 1.2 GiB
[2022-07-27 16:05:55] Server     INFO    Java:   11.0.2
[2022-07-27 16:05:55] Server     INFO    OS:     Mac OS X 10.16 x86_64
[2022-07-27 16:05:55] Server     INFO    PID:    8101
[2022-07-27 16:05:55] Server     INFO  Started 2022/07/27 16:05:55 EDT on port 3030
```

Go to `http://localhost:3030/`. Click on the "Query" action for the dataset,
'/tdb2-database', and run the default query.

Use the `Control-C` key combination to stop the server.

## Usage

In this project folder, create a folder called `data` if it doesn't already
exist.

```bash
cd path/to/sdbm-jena-fuseki
mkdir data
```

From the [SDBM downloads page][sdbm-downloads], download the lasted
version of the SDBM TTL file to the `data` folder and unzip it,
using the correct name of the TTL file.

```bash
gunzip data/output-20220727T050002-UTC.ttl.gz
```

Warning: The unzipped file is very large, ~1 GB. It will take a long
time to load, and once loaded, you will probably want to re-compress it when
it's been loaded.

[sdbm-downloads]: https://sdbm.library.upenn.edu/downloads> "SDBM downloads page"

Remove the `TDB2` directory and load the data into Jena.

```bash
rm -rf TDB2
# the following creates the `TDB2` folder
tdb2.tdbloader --verbose --loc TDB2 data/output-20220727T050002-UTC.ttl
```

Start Fuseki:

```bash
./start-fuseki.sh
```

Use the `Control-C` key combination to stop the server.
