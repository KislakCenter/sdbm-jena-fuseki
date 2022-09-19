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

Confirm that you have Java installed by running the `java` command.

```shell
$ java --version
java 11.0.2 2019-01-15 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.2+9-LTS, mixed mode)
```

Your output will differ depending on the Java version you have install.
If you get an error, refer to the Java website installation instructions
for your operating system.

Create a folder on your Linux/MacOS computer home directory called `Java`.

```shell
$ mkdir $HOME/Java
```

This will create a folder like `/home/<YOUR_USER>/Java` or 
`/Users/<YOUR_USER>/Java`.

Download and unzip the these files in the new `Java directory`:

- <http://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-4.5.0.zip>
- <http://archive.apache.org/dist/jena/binaries/apache-jena-4.5.0.zip>

NOTE: You can use a more recent version of Jena and Jena-Fuseki, but you'll
need to adjust the `FUSEKI_HOME` AND `JENA_HOME` variables described below
for your environment.

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

You can add these lines to your `$HOME/.bashrc` file or, if you're running ZSH
(the default on MacOS) to `$HOME/.zshrc`.

### Test the setup

There are two steps here:

1. Load the test data into Jena
2. Query the data using Fuseki

#### Load the test data into Jena

Make sure the `FUSEKI_HOME`, `JENA_HOME` and `PATH` values are set in your
environment either by adding the lines in the `.sdbmjfrc` to `$HOME/.bashrc`
or `$HOME/.zshrc`, or by sourcing the `.sdbmjfrc`:

```shell
source .sdbmjfrc
```

If you already have a folder called `TDB2`, delete it and reload the `ttl`
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

Go to `http://localhost:3030/#/`. Click on the "Query" action for the dataset,
'/sdbm', and run the default query.

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


[sdbm-downloads]: https://sdbm.library.upenn.edu/downloads "SDBM downloads page"

Make sure the `FUSEKI_HOME`, `JENA_HOME` and `PATH` values are set in your
environment either by adding the lines in the `.sdbmjfrc` to `$HOME/.bashrc`
or `$HOME/.zshrc`, or by sourcing the `.sdbmjfrc`:

```shell
# if you've just added the lines to .bashrc
source $HOME/.bashrc

# if you've just added the lines to .zshrc
source $HOME/.zshrc

# if you've haven't already run, source .sdbmjfrc in this shell session
source .sdbmjfrc
```

Remove the `TDB2` directory and load the data into Jena. 

Note: The SDBM TTL file is very large (over 1GB), and the load will take
several minutes.

```bash
rm -rf TDB2
# the following creates the `TDB2` folder
# substute `output-20220727T050002-UTC.ttl` with the correct file name
tdb2.tdbloader --verbose --loc TDB2 data/output-20220727T050002-UTC.ttl
```

Start Fuseki:

```bash
./start-fuseki.sh
```

Use the `Control-C` key combination to stop the server.

Go to `http://localhost:3030/#/`. Click on the "Query" action for the dataset,
'/sdbm', and run the default query.

### Clean up

As noted above the TTL is quite large. After loader process has finished,
be sure to zip the TTL file in the `data` folder. Don't delete it, as 
it may be needed again.
