#
# Simple orchestration for variant prediction experiment
#

.PHONY: clean finetune run call_substitutions

clean:
	python ./src/clean_fasta.py

finetune:
	python ./src/run_clm.py --model_name_or_path nferruz/ProtGPT2 \
					  --train_file ./calc/train.txt \
					  --validation_file ./calc/test.txt \
					  --tokenizer_name nferruz/ProtGPT2 \
					  --block_size 256 \
					  --do_train \
					  --do_eval \
					  --output_dir model_out \
					  --learning_rate 1e-05	\
					  --overwrite_output_dir\


run:
	python ./src/run_finetuned_model.py ./model_out

call_substitutions:
	python ./src/call_aa_variants.py

visualize:
	Rscript ./src/manuscript_figures.R
	Rscript ./src/supplementary_figures.R
