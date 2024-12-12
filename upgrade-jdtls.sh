
log-echo() {
    echo -e "♪♪♪ $1\n"
}


JDTLS_SERVER='https://download.eclipse.org/jdtls/snapshots'
LATEST_FILE_TXT='/latest.txt'
LATEST_FILE_LOCAL='jdt-language-server-latest.tar.gz'

upgrade_jdtls() {
    # if [ -f $LATEST_FILE_LOCAL ];
    LATEST_FILE_NAME=$(curl -s ${JDTLS_SERVER}${LATEST_FILE_TXT})
    LATEST_FILE_SHA256=$(curl -s ${JDTLS_SERVER}/${LATEST_FILE_NAME}.sha256)
    if [ -f $LATEST_FILE_LOCAL ]; then
        LOCAL_FILE_SHA256=$(sha256sum $LATEST_FILE_LOCAL)
        if [ "$LATEST_FILE_SHA256" == "$LATEST_FILE_SHA256" ]; then
            log-echo "Latest file already exists."
            return
        fi

    else
        log-echo "Latest file does NOT exist, now downloading..."
    fi

    wget -c ${JDTLS_SERVER}/${LATEST_FILE_NAME} -O tmp.tar.gz
    mv tmp.tar.gz $LATEST_FILE_LOCAL

    log-echo "Unzipping file..."
    if [ -d "jdtls" ]; then
        rm -rf jdtls
    fi

    mkdir jdtls
    tar -xvf $LATEST_FILE_LOCAL -C jdtls
    log-echo "Done."
}

upgrade_jdtls
