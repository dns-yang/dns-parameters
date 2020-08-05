# DNS Parameters

YANG modules with types representing various DNS-related parameters.

Modules that mirror IANA registries should be generated from the current contents of each registry by using a corresponding XSLT stylesheet from the [XSLT](https://github.com/dns-yang/dns-parameters/tree/master/XSLT) directory. The included [Makefile](https://github.com/dns-yang/dns-parameters/blob/master/Makefile) automates these transformations (prerequisites are [curl](https://curl.haxx.se/) and [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html)).

After running `make`, the following YANG modules will be present:

* _iana-dns-class-rr-type_: [DNS CLASSes and RR TYPEs](https://www.iana.org/assignments/dns-parameters)
* _dns-yang-tsig-algorithms_: [TSIG Algorithm Names](https://www.iana.org/assignments/tsig-algorithm-names)
