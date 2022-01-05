#!/bin/bash

var() {
    arr[0]="bot: 👋 Hello Github!"
    arr[1]="bot: 🥳 Yeayyy!"
    arr[2]="bot: 😬 Working from github."
    arr[3]="bot: 👨‍💻 Work, work, work!"
    arr[4]="bot: 🥳 UPdate Quotes:)"
    arr[5]="bot: 😎 New quotes!"
    arr[6]="bot: 🙄 Running task, again."
    arr[7]="bot: 👻 New word."

    api[0]="https://zenquotes.io/api/random"

    rand=$[$RANDOM % ${#arr[@]}]
    rapi=$[$RANDOM % ${#api[@]}]
}

main() {
    echo "<h2 align=\"center\"> Hi, tyaz here!</h2>

<p align=\"center\">
<a href=\"https://github.com/tyazx\" alt=\"github streak\"><img src=\"https://dvst-streak.herokuapp.com/?user=tyazx&theme=tokyonight&fire=DD472C\"></a>
</p>

<hr>
<h3 align=\"center\">Quote of The Day</h3>
<p align=\"center\">
<blockquote>
<i>\"${quote}\"</i>
<br>
<b>- ${author}</b>
</blockquote>
</p>


<hr>
<h2 align=\"center\">Thank You 🙏🏼</h2>" > README.md
}

clean() {
    if [[ "$1" == "post" ]]; then
        rm -rf data.json
    elif [[ -z "$1" ]]; then
        rm -rf data.json README.md
    fi
}

quotes() {
    if curl -s ${api[$rapi]} > data.json; then
        cat data.json
        quote=$(jq -r '.[] .q' data.json)
        author=$(jq -r '.[] .a' data.json)
    else
        echo "Fetch quotes api failed!"
        exit 1
    fi

    if [[ -z "${quote}" || -z "${author}" ]]; then
        echo "Fetch quotes failed!"
        exit 1
    fi
}


push() {
    git config --local user.email "74433495+tyazx@users.noreply.github.com"
    git config --local user.name "tyazx"
    git commit -am "${arr[$rand]} (${tgl})"
}

##### START #####
tgl=$(date '+%D %R %Z')
clean
var
quotes
main
clean post
push
