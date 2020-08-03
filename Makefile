REGMODS = iana-dns-class-rr-type

reg_mods = $(addsuffix .yang, $(REGMODS))

.PHONY: all clean

all: $(reg_mods)

iana-dns-class-rr-type.yang: XSLT/iana-dns-class-rr-type.xsl
	@curl https://www.iana.org/assignments/dns-parameters/dns-parameters.xml | \
	xsltproc -o $@ $< -

clean:
	@rm -rf $(reg_mods)
