# default-browser

I wrote this tool to programatically swap your default browser in OSX. Since
I use the Safari Technology Previow for my personal things, and Chrome for work 
things, it's nice to be able to toggle between the two when I leave the office.


## Usage

```
$ default-browser [bundle identifier]
```

Sets the default browser to the Application's bundle identifier (say, "com.apple.Safari")

```
$ default-browser http[s?]
```

Prints a list of bundle identifiers for Applications that handle the HTTP or HTTPS 
protocol.

```
$ default-browser current
```

Prints the current default browser for HTTP URLs.

```
$ default-browser
```

Calling the command with no arguments simply the default browser between
Google Chrome and the Safari Technology Preview
