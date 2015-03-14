js:
	../pandoc/.cabal-sandbox/bin/pandoc haskell-microservices.md -s -S \
		--variable theme="beige" --variable transition="linear" \
		 -t revealjs -o index.html

pdf:
	../pandoc/.cabal-sandbox/bin/pandoc haskell-microservices.md \
		--highlight-style=tango -t beamer -o haskell-microservices.pdf
