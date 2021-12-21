if [ ! -f mirrorlist ]; then
    iso=$(curl -4 ifconfig.co/country-iso)
    sudo reflector --age 6 --latest 20 --fastest 20 --threads 20 --sort rate --protocol https -c ${iso} --save ${PWD}/mirrorlist
fi
docker build -t nvim .
