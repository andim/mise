# convert Mathematica formula to python expression
# modified from a cc-by licensed script by Bennett Kanuka
# (https://gist.github.com/bkanuka/10744247)
# usage: cat input | perl nb_to_py.pl

#!/usr/bin/env perl

# loop through every line on stdin
while (<>) {
    s/[^!-~\s]//g;      # strip non-ascii characters
    s/{{x\[t\]->//g;    # remove beginning {{x[t]->
    s/}}//g;            # remove ending }}
    s/\+\n/\+/g;        # add line breaks at ever + or -
    s/\-\n/\-/g;


    # replace ^x with **x
    s/\^([0-9a-z]+)/**$1/g;

    # replace integer x/y with x.0/y so that python does float division
    s/([0-9]+)\/([0-9]+)/($1.0\/$2)/g;

    # Replace greek symbols 
    s/\\\[(\w{2,7})\]/\L$1/g;

    # escape greek lambda (python keyword)
    s/lambda/lambda_/g;

    # replace E^( with np.exp(
    s/E\^\(/np.exp(/g;
    # replace E^x with np.exp(x)
    s/E\^(\-?[0-9a-z_]+)/np.exp($1)/g;

    # replace Exp with np.exp
    s/Exp/np.exp/g;
    # replace Abs with np.abs
    s/Abs/np.abs/g;
    # replace Log with np.log
    s/Log/np.log/g;

    # make round brackets from curly brackets
    s/\[/(/g;
    s/\]/)/g;

    # replace whitespace with * (for multiplication)
    s/([a-z0-9)])\s+(?=[a-z0-9(])/$1 * /ig;

    # put a space around - and +
    #s/([^(])-/$1 - /g;
    #s/(.)\+(.)/$1 + $2/g;

    print; 
    }
