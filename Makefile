REGMODS = iana-dns-class-rr-type dns-yang-tsig-algorithms
YINTOOLS = ../yin-tools
iana-dns-class-rr-type_URL = dns-parameters
dns-yang-tsig-algorithms_URL = tsig-algorithm-names

yxslt = $(YINTOOLS)/xslt
reg_mods = $(addsuffix .yang, $(REGMODS))
reg_modx = $(addsuffix .yinx, $(REGMODS))
base = https://www.iana.org/assignments
yxslpars =

.PHONY: all clean

all: $(reg_mods)

yinx: $(reg_modx)

%.yinx: xslt/%.xsl
	curl $(base)/$($*_URL)/$($*_URL).xml | xsltproc -o $@ $< -

%.yang: %.yinx
	xsltproc $(yxslt)/canonicalize.xsl $< | \
	xsltproc --output $@ $(yxslpars) $(yxslt)/yin2yang.xsl -

clean:
	@rm -rf $(reg_mods) $(reg_modx)
