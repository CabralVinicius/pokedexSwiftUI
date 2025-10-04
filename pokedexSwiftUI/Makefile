PROJECT      := pokedexSwiftUI.xcodeproj
SCHEME       := pokedexSwiftUI
CONFIG       := Debug
DEST         := generic/platform=iOS Simulator
DDIR         := .build/DerivedData
ARCHIVE_LOG  := build.log

# Filtro de "ruído" (adicione termos que você quer esconder)
NOISE_FILTER := -e appintentsmetadataprocessor -e "No AppShortcuts found"

.PHONY: build
build:
	@echo "🔨 Building $(SCHEME) (silencioso e sem boot do simulador)…"
	@rm -rf $(DDIR)
	@mkdir -p $(DDIR)
	@set -o pipefail; \
	xcodebuild build \
		-project "$(PROJECT)" \
		-scheme "$(SCHEME)" \
		-configuration "$(CONFIG)" \
		-destination '$(DEST)' \
		-derivedDataPath "$(DDIR)" \
		-showBuildTimingSummary \
		-disableAutomaticPackageResolution \
		| tee "$(ARCHIVE_LOG)" >/dev/null
	@$(MAKE) _report
	@echo "🧹 Limpando DerivedData local…"
	@rm -rf "$(DDIR)"

.PHONY: _report
_report:
	@echo "——— 📄 RESUMO ———"
	@STATUS=$$(grep -Fq "** BUILD SUCCEEDED **" "$(ARCHIVE_LOG)" && echo "SUCCEEDED" || echo "FAILED"); \
	if [ "$$STATUS" = "SUCCEEDED" ]; then \
	  echo "✅ BUILD SUCCEEDED"; \
	else \
	  echo "❌ BUILD FAILED"; \
	fi; \
	\
	WARN=$$(grep -E ":[0-9]+:[0-9]+: warning:" "$(ARCHIVE_LOG)" 2>/dev/null | grep -v $(NOISE_FILTER) | wc -l | tr -d ' '); \
	ERR=$$(grep -E ":[0-9]+:[0-9]+: error:"   "$(ARCHIVE_LOG)" 2>/dev/null | wc -l | tr -d ' '); \
	[ -z "$$WARN" ] && WARN=0; [ -z "$$ERR" ] && ERR=0; \
	echo "⚠️  Warnings: $$WARN"; \
	echo "⛔  Erros:    $$ERR"; \
	echo; \
	if [ "$$ERR" -gt 0 ]; then \
	  echo "— Erros —"; \
	  grep -E ":[0-9]+:[0-9]+: error:" "$(ARCHIVE_LOG)" \
	    | sed -E 's#^/Users/.*/pokedexSwiftUI/##' \
	    | awk '!seen[$$0]++' | head -n 50; \
	  echo; \
	fi; \
	if [ "$$WARN" -gt 0 ]; then \
	  echo "— Warnings (filtrados) —"; \
	  grep -E ":[0-9]+:[0-9]+: warning:" "$(ARCHIVE_LOG)" \
	    | grep -v $(NOISE_FILTER) \
	    | sed -E 's#^/Users/.*/pokedexSwiftUI/##' \
	    | awk '!seen[$$0]++' | head -n 50; \
	  echo; \
	fi; \
	echo "— Build Timing Summary —"; \
	awk '/^Build Timing Summary/{flag=1;next}/^[[:space:]]*$$/{flag=0}flag' "$(ARCHIVE_LOG)" | sed 's/^/  /'