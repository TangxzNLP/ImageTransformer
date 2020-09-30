id="wh"
#word_count_threshold=4
if [ ! -f log/log_$id/infos_$id.pkl ]; then
start_from=""
else
start_from="--start_from log/tmp/log_$id"
fi
#start_from=""
#start_from="--start_from log/tmp/train_h11/log_h"
# start_from="--start_from log/tmp/train_b16_sal_tr_preaoa_4/log_$id"
#sal_idex=_sml61
#echo $word_count_threshold
#echo $start_from
CUDA_VISIBLE_DEVICES=0 python train_h.py --id $id \
	--caption_model aoa0 \
	--refine 1 \
	--refine_aoa 0 \
	--use_ff 0 \
	--decoder_type AoA \
	--use_multi_head 2 \
	--num_heads 8 \
	--multi_head_scale 1 \
	--mean_feats 1 \
	--ctx_drop 1 \
	--dropout_aoa 0.3 \
	--label_smoothing 0.2 \
	--input_json data/tmp/4/cocotalk.json \
	--input_label_h5 data/tmp/4/cocotalk_label.h5 \
	--input_fc_dir  data/adaptive/cocobu_fc \
	--input_att_dir  data/adaptive/cocobu_att  \
	--input_box_dir  data/adaptive/cocobu_box \
	--input_flag_dir data/tmp/cocobu_flag_$id \
	--seq_per_img 5 \
	--batch_size 10 \
	--beam_size 1 \
	--learning_rate 2e-4 \
	--num_layers 2 \
	--input_encoding_size 1024 \
	--rnn_size 1024 \
	--learning_rate_decay_start 0 \
	--scheduled_sampling_start 0 \
	--name_append ""\
	--checkpoint_path log/tmp/train_ours/log_$id  \
	$start_from \
	--save_checkpoint_every 6000 \
	--language_eval 1 \
	--val_images_use -1 \
	--max_epochs 25 \
	--scheduled_sampling_increase_every 5 \
	--scheduled_sampling_max_prob 0.5 \
	--learning_rate_decay_every 3 \
	--use_warmup 0

CUDA_VISIBLE_DEVICES=0 python train_h.py --id $id \
    --caption_model aoa0 \
    --refine 1 \
    --refine_aoa 0 \
    --use_ff 0 \
    --decoder_type AoA \
    --use_multi_head 2 \
    --num_heads 8 \
    --multi_head_scale 1 \
    --mean_feats 1 \
    --ctx_drop 1 \
    --dropout_aoa 0.3 \
    --input_json data/tmp/4/cocotalk.json \
    --input_label_h5 data/tmp/4/cocotalk_label.h5 \
    --input_fc_dir  data/adaptive/cocobu_fc \
    --input_att_dir  data/adaptive/cocobu_att  \
    --input_box_dir  data/adaptive/cocobu_box \
    --input_flag_dir data/tmp/cocobu_flag_$id \
    --seq_per_img 5 \
    --batch_size 10 \
    --beam_size 1 \
    --num_layers 2 \
    --input_encoding_size 1024 \
    --rnn_size 1024 \
    --language_eval 1 \
    --val_images_use -1 \
    --save_checkpoint_every 6000 \
    --name_append ""\
    --start_from log/tmp/train_ours/log_$id \
    --checkpoint_path log/tmp/train_ours/log_$id"_rl" \
    --learning_rate 2e-5 \
    --max_epochs 50 \
    --self_critical_after 0 \
    --learning_rate_decay_start -1 \
    --scheduled_sampling_start -1 \
    --reduce_on_plateau 
