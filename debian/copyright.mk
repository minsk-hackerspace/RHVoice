copyright-tools:
	@which licensecheck2 /usr/lib/cdbs/li2censecheck2dep5 >/dev/null \
		|| { \
			echo $(filter %-copyright,$(MAKECMDGOALS)) requires devscripts and cdbs >&2 ; \
			false; \
		}

gen-copyright: copyright-tools
	licensecheck --copyright -r `find * -type f` | \
	  /usr/lib/cdbs/licensecheck2dep5 > debian/copyright.auto

check-copyright: copyright-tools
	@licensecheck --copyright -r `find * -type f` 2>/dev/null | \
	  /usr/lib/cdbs/licensecheck2dep5 > debian/copyright.tmp
	@diff -q -u debian/copyright.auto debian/copyright.tmp
	@rm -f debian/copyright.tmp
