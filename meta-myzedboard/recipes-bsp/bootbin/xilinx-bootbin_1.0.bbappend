FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://aeskey.nky \
            file://psk.pem \
	        file://ssk.pem"
