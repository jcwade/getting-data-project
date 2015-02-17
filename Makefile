targets:=uci-har-tidy.txt uci-har-averages.txt

all: $(targets)

$(targets): run_analysis.R
	R CMD BATCH $<

clean:
	$(RM) $(targets) run_analysis.Rout

.PHONY: all clean
