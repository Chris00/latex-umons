TARBALL = /tmp/memoire-umons.tgz

WEB = san@mathinfo.umons.ac.be:~/public_html/documents

GENERATED_FILES=lorentz.eps.gz lorentz.eps.bb

FILES = memoire-umons.cls $(wildcard *.tex *.eps *.pdf *.png *.jpg) \
  $(GENERATED_FILES)

.PHONY: tar upload
tar: $(GENERATED_FILES)
	tar --dereference -zcf $(TARBALL) $(FILES)

upload: tar
	scp $(TARBALL) $(WEB)

lorentz.eps: lorentz.png
	convert $< $@

lorentz.eps.gz: lorentz.eps
	gzip -9 --force $<
lorentz.eps.bb: lorentz.eps.gz
	zgrep %%BoundingBox $< > $@

.PHONY: clean
clean::
	$(RM) $(wildcard *aux *.log *.out) memoire-umons-manual.{dvi,ps,pdf}
	$(RM) $(GENERATED_FILES)
	$(RM) -rf auto/
