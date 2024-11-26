#!/bin/sh

#### Given a list of NuGet packages, browse for their licences
#### Creates a CSV file separated by tabs, with the columns:
#### licence (or "check" if not found), URL (review if "check" was printed)

[ $# -ne 1 ] && {
    printf 'Usage: %s [LIST OF NUGET PACKAGES]\n' "$0" >&2
    exit 1
}

while read line
do
    curl -s https://www.nuget.org/packages/"$line" |\
        sed -n -E '
/github.com.*LICENSE/{
    s,.*href="([^"]+).*,check\t\1,
    p
    q
}
/licenses\.nuget\.org/{
    /<span>OR<\/span>/{
        s,.*licenses\.nuget\.org/([^"]+).*licenses\.nuget\.org/([^"]+).*,\1 or \2\thttps://www.nuget.org/packages/'"$line"',
        p
        q
    }
    s/.*licenses\.nuget\.org\///
    s/".*//
    s,$,\thttps://www.nuget.org/packages/'"$line"',
    p
    q
}
${
    s,.*,check\thttps://www.nuget.org/packages/'"$line"',
    p
}
'
done < "$1"

