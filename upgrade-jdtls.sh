log-echo() {
    echo -e "\n🍒🍒🍒 $1\n"
}


JDTLS_SERVER='https://download.eclipse.org/jdtls/snapshots'
LATEST_FILE_TXT='/latest.txt'

upgrade_jdtls() {
    # if [ -f $LATEST_FILE_LOCAL ];
    LATEST_FILE_NAME=$(curl -s ${JDTLS_SERVER}${LATEST_FILE_TXT})
    LATEST_FILE_SHA256=$(curl -s ${JDTLS_SERVER}/${LATEST_FILE_NAME}.sha256)
    echo -e "LatestFile $LATEST_FILE_NAME\n  " | column -t
    if [ -f $LATEST_FILE_NAME ]; then
        LOCAL_FILE_SHA256=$(sha256sum $LATEST_FILE_NAME | awk '{print $1}')
        echo -e "ExpectSHA256 $LATEST_FILE_SHA256\n
                LocalSHA256 $LOCAL_FILE_SHA256" | column -t

        if [ "$LATEST_FILE_SHA256" == "$LATEST_FILE_SHA256" ]; then
            log-echo "Latest file already exists."
            return
        fi

    else
        log-echo "Latest file does NOT exist, now downloading..."
    fi

    wget -q --show-progress -c ${JDTLS_SERVER}/${LATEST_FILE_NAME} -O $LATEST_FILE_NAME

    log-echo "Unzipping file..."
    if [ -d "jdtls" ]; then
        rm -rf jdtls
    fi

    mkdir jdtls
    tar -xvf $LATEST_FILE_NAME -C jdtls
    log-echo "Done."
}

upgrade_jdtls
