#!/bin/sh

# check to see if this file is being run or sourced from another script
_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

# setup SSL certificates
_setup_certificate() {
	if [ -r "${SSL_CERTIFICATE}" ] && [ -r "${SSL_CERTIFICATE_KEY}" ]; then
		openssl pkcs12 -export -in "${SSL_CERTIFICATE}" -inkey "${SSL_CERTIFICATE_KEY}" -out "/etc/davmail/davmail.p12" -passout pass:"davmail"
		chown davmail /etc/davmail/davmail.p12
	fi
}

_main() {
	_setup_certificate
	if [ "$(id -u)" = '0' ]; then
		# then restart script as davmail user
		/sbin/su-exec davmail:1000 /docker-entrypoint.sh "$@"
	fi

	exec "$@"
}

if ! _is_sourced; then
	_main "$@"
fi
