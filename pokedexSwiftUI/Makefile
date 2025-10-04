PROJECT      := pokedexSwiftUI.xcodeproj
SCHEME       := pokedexSwiftUI
CONFIG       := Debug
DEST         := generic/platform=iOS Simulator
DDIR         := .build/DerivedData
ARCHIVE_LOG  := build.log

# --- NOVO: destino único p/ não abrir vários simuladores ---
SIM_NAME     := iPhone 17 Pro
SIM_OS       := 26.0

# Filtro de "ruído"
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
	if [ "$$STATUS" = "SUCCEEDED" ]; then echo "✅ BUILD SUCCEEDED"; else echo "❌ BUILD FAILED"; fi; \
	WARN=$$(grep -E ":[0-9]+:[0-9]+: warning:" "$(ARCHIVE_LOG)" 2>/dev/null | grep -v $(NOISE_FILTER) | wc -l | tr -d ' '); \
	ERR=$$(grep -E ":[0-9]+:[0-9]+: error:"   "$(ARCHIVE_LOG)" 2>/dev/null | wc -l | tr -d ' '); \
	[ -z "$$WARN" ] && WARN=0; [ -z "$$ERR" ] && ERR=0; \
	echo "⚠️  Warnings: $$WARN"; echo "⛔  Erros:    $$ERR"; echo; \
	if [ "$$ERR" -gt 0 ]; then echo "— Erros —"; \
	  grep -E ":[0-9]+:[0-9]+: error:" "$(ARCHIVE_LOG)" \
	    | sed -E 's#^/Users/.*/pokedexSwiftUI/##' \
	    | awk '!seen[$$0]++' | head -n 50; echo; fi; \
	if [ "$$WARN" -gt 0 ]; then echo "— Warnings (filtrados) —"; \
	  grep -E ":[0-9]+:[0-9]+: warning:" "$(ARCHIVE_LOG)" \
	    | grep -v $(NOISE_FILTER) \
	    | sed -E 's#^/Users/.*/pokedexSwiftUI/##' \
	    | awk '!seen[$$0]++' | head -n 50; echo; fi; \
	echo "— Build Timing Summary —"; \
	awk '/^Build Timing Summary/{flag=1;next}/^[[:space:]]*$$/{flag=0}flag' "$(ARCHIVE_LOG)" | sed 's/^/  /'

# =========================
#         TESTES
# =========================

RESULT_BUNDLE := .build/TestResults.xcresult
TEST_LOG      := test.log

.PHONY: test
test:
	@echo "🧪 Rodando testes do esquema $(SCHEME) em 1 simulador (sem paralelismo)…"
	@rm -rf $(DDIR) $(RESULT_BUNDLE)
	@mkdir -p $(DDIR)
	@set -o pipefail; \
	xcodebuild test \
		-project "$(PROJECT)" \
		-scheme "$(SCHEME)" \
		-configuration "$(CONFIG)" \
		-destination 'platform=iOS Simulator,name=$(SIM_NAME),OS=$(SIM_OS)' \
		-derivedDataPath "$(DDIR)" \
		-enableCodeCoverage YES \
		-parallel-testing-enabled NO \
		-maximum-parallel-testing-workers 1 \
		-resultBundlePath $(RESULT_BUNDLE) \
		| tee "$(TEST_LOG)" >/dev/null
	@$(MAKE) _test_report
	@echo "🧹 Limpando DerivedData local…"
	@rm -rf "$(DDIR)"

# Rode um único caso ou classe:
# make test_one TEST_CLASS=OnboardingViewModelTests
# make test_one TEST_CLASS=OnboardingViewModelTests TEST_NAME=testInitialState
.PHONY: test_one
test_one:
	@echo "🧪 Rodando teste filtrado ($(TEST_BUNDLE)/$(TEST_CLASS)/$(TEST_NAME))…"
	@test -n "$(TEST_CLASS)" || (echo "❌ Informe TEST_CLASS=<ClasseDeTeste>"; exit 2)
	@ARGS=""; \
	if [ -n "$(TEST_NAME)" ]; then \
	  ARGS=" -only-testing:$(TEST_BUNDLE)/$(TEST_CLASS)/$(TEST_NAME)"; \
	else \
	  ARGS=" -only-testing:$(TEST_BUNDLE)/$(TEST_CLASS)"; \
	fi; \
	set -o pipefail; \
	xcodebuild test \
		-project "$(PROJECT)" \
		-scheme "$(SCHEME)" \
		-configuration "$(CONFIG)" \
		-destination 'platform=iOS Simulator,name=$(SIM_NAME),OS=$(SIM_OS)' \
		-derivedDataPath "$(DDIR)" \
		-enableCodeCoverage YES \
		-parallel-testing-enabled NO \
		-maximum-parallel-testing-workers 1 $$ARGS \
		-resultBundlePath .build/TestResults.xcresult \
		| tee "$(TEST_LOG)" >/dev/null
	@$(MAKE) _test_report

.PHONY: _test_report
_test_report:
	@echo "——— 🧾 RESUMO TESTS ———"
	@STATUS=$$(grep -Fq "** TEST SUCCEEDED **" "$(TEST_LOG)" && echo "SUCCEEDED" || echo "FAILED"); \
	if [ "$$STATUS" = "SUCCEEDED" ]; then echo "✅ TESTS PASSED"; else echo "❌ TESTS FAILED"; fi; \
	FAILS=$$(grep -E "Test (Case|Suite) '-.*' failed" "$(TEST_LOG)" | wc -l | tr -d ' '); \
	echo "❗ Falhas reportadas: $$FAILS"; \
	if [ "$$FAILS" -gt 0 ]; then \
	  echo; echo "— Falhas (resumo) —"; \
	  grep -E "(/.*:[0-9]+)|(: error: )" "$(TEST_LOG)" \
	    | sed -E 's#^/Users/.*/pokedexSwiftUI/##' \
	    | awk '!seen[$$0]++' | head -n 100; \
	  echo; \
	fi