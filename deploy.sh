if [ "$1" = "-i" ]
then
    mkdir output
    cd output
    git clone -b gh-pages git@github.com:linxunchen/wiki.git ./
    cd ..
    exit 0
elif [ "$1" = "" ]
then
    echo deploy [Option]
    echo '-i init'
    echo 'message  this is message'
    exit 0
else
    git add . --all
    git commit -mmaster
    git pull origin master
    git push origin master

    simiki g
    cd output
    git add . --all
    git commit -m good
    git pull origin gh-pages
    git push origin gh-pages
    cd ..


fi
