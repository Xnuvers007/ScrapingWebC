# are you using vcpkg or debian
echo "===================================="
echo "Welcome to the C++ Web Scraper"
echo "===================================="
echo "Are you using vcpkg or debian? (v/u)"
read jawab
if [ $jawab = "v"]
then
    vcpkg install curl
    vcpkg install gumbo
    vcpkg integrate install
    echo "Done..."
else
    echo "Installing Requirements..."
    sudo apt install libcurl4-openssl-dev libgumbo-dev
    echo "Done..."
fi

git clone https://github.com/google/gumbo-parser.git
git clone https://github.com/curl/curl.git

#mv ./curl2 ./curl
#mv ./gumbo-parser2 ./gumbo-parser

# curl install
echo "===================================="
cd ./curl
autoreconf -fi
./configure
make
# loading 3 seconds
for i in {1..3}
do
    echo "Loading..."
    sleep 1
done
echo "done..."

# gumbo install
echo "===================================="
cd ../gumbo-parser
./autogen.sh
./configure
make && make install

echo "Do You have a C++ compiler installed? (y/n)"
read answer
if [ $answer = "y" ]
then
    echo "Compiling..."
    g++ main.cc -lcurl -lgumbo -std=c++17 -o main
    echo "Running..."
    ./main doom
else
    echo "Please install a C++ compiler"
    echo "Do You Want to install it ? (y/n)"
    read answer
    if [ $answer = "y" ]
    then
        echo "Installing..."
        sudo apt install g++
        echo "Compiling..."
        g++ main.cc -lcurl -lgumbo -std=c++17 -o main
        echo "Running..."
        ./main doom
    else
        echo "Exiting..."
    fi
fi

# g++ main.cc -lcurl -lgumbo -std=c++17 -o main
# ./main doom
