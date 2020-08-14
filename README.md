# DNS Parameters

YANG modules with types representing various DNS-related parameters.

Modules that mirror IANA registries are generated from the current contents of each registry by using a corresponding XSLT stylesheet from the [XSLT](https://github.com/dns-yang/dns-parameters/tree/master/XSLT) directory. The included [Makefile](https://github.com/dns-yang/dns-parameters/blob/master/Makefile) automates these transformations. After running `make`, the following YANG modules will be present:

* _iana-dns-class-rr-type_: [DNS CLASSes and RR TYPEs](https://www.iana.org/assignments/dns-parameters)
* _dns-yang-tsig-algorithms_: [TSIG Algorithm Names](https://www.iana.org/assignments/tsig-algorithm-names)

## Prerequisites

* [curl](https://curl.haxx.se/)
* [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html)
* GitHub project [yin-tools](https://github.com/llhotka/yin-tools) – the local directory where this project is cloned should be specified in the Makefile (variable `YINTOOLS`).
