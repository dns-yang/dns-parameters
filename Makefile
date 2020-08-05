REGMODS = iana-dns-class-rr-type dns-yang-tsig-algorithms
iana-dns-class-rr-type_URL = dns-parameters
dns-yang-tsig-algorithms_URL = tsig-algorithm-names

reg_mods = $(addsuffix .yang, $(REGMODS))
base = https://www.iana.org/assignments

.PHONY: all clean

all: $(reg_mods)

%.yang: XSLT/%.xsl
	curl $(base)/$($*_URL)/$($*_URL).xml | xsltproc -o $@ $< -

clean:
	@rm -rf $(reg_mods)
