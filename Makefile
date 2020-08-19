REGMODS = iana-dns-class-rr-type dns-yang-tsig-algorithms \
	dns-yang-dnssec-algorithms
YINTOOLS = ../yin-tools
iana-dns-class-rr-type_URL = dns-parameters
dns-yang-tsig-algorithms_URL = tsig-algorithm-names
dns-yang-dnssec-algorithms_URL = dns-sec-alg-numbers

yxslt = $(YINTOOLS)/xslt
yrng = $(YINTOOLS)/schema
reg_mods = $(addsuffix .yang, $(REGMODS))
reg_modx = $(addsuffix .yinx, $(REGMODS))
base = https://www.iana.org/assignments
yxslpars =

.PHONY: all clean validate yinx

all: $(reg_mods)

yinx: $(reg_modx)

%.yinx: xslt/%.xsl
	curl $(base)/$($*_URL)/$($*_URL).xml | xsltproc -o $@ $< -

%.yang: %.yinx
	xsltproc $(yxslt)/canonicalize.xsl $< | \
	xsltproc --output $@ $(yxslpars) $(yxslt)/yin2yang.xsl -

validate: $(reg_modx)
	jing $(yrng)/yin-html.rng $^

clean:
	@rm -rf $(reg_mods) $(reg_modx)
