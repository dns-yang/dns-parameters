REGMODS = iana-dns-class-rr-type dns-yang-tsig-algorithms

reg_mods = $(addsuffix .yang, $(REGMODS))

.PHONY: all clean

all: $(reg_mods)

iana-dns-class-rr-type.yang: XSLT/iana-dns-class-rr-type.xsl
	@curl https://www.iana.org/assignments/dns-parameters/dns-parameters.xml | \
	xsltproc -o $@ $< -

dns-yang-tsig-algorithms.yang: XSLT/dns-yang-tsig-algorithms.xsl
	@curl https://www.iana.org/assignments/tsig-algorithm-names/tsig-algorithm-names.xml | \
	xsltproc -o $@ $< -

clean:
	@rm -rf $(reg_mods)
