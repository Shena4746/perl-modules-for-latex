# perl requirements for latex(indent)
FROM alpine:3.17.0 AS dev-perl
RUN apk add --no-cache --virtual .fetch-deps \
	make \
	perl-app-cpanminus
RUN apk add --no-cache \
	perl \
	xz
RUN apk add --no-cache \
	perl-yaml-tiny \
	perl-log-dispatch \
	perl-unicode-linebreak \
	perl-log-log4perl
RUN cpanm File::HomeDir
# tar perl modules to later resolve symbolic links of compressed files
# + some binary files
RUN tar czf /modules.tar.gz \
	/usr/local/share/perl5/site_perl \
	/usr/lib/perl5/vendor_perl \
	/usr/share/perl5/vendor_perl
RUN apk del --purge .fetch-deps

# usage 
# COPY --from=dev-perl /modules.tar.gz /modules.tar.gz
# RUN tar xzf modules.tar.gz 