#! /bin/bash

if [ $# -eq 0 ]
then
    printf "Script to launch more than one training. There are two options:\n 1) If the first argument is \"folder\", the second argument must be the folder path where all the config files are included.\n 2) Without giving \"folder\" as first argument, you can give each config files manually.\n"
    echo "Invalid argument number. No config files have been given."
    exit
fi

if [ $1 == "folder" ]
then
    search_dir=$2
    for entry in $search_dir/*
    do
        echo "##### Config files: $entry #####"
        python train_net.py --num-gpus 1 --config $entry SOLVER.IMG_PER_BATCH_LABEL 4 SOLVER.IMG_PER_BATCH_UNLABEL 4
    done
else
    for training in $@
    do
        echo "##### Config files: $training #####"
        python train_net.py --num-gpus 1 --config configs/coco_supervision/$training SOLVER.IMG_PER_BATCH_LABEL 4 SOLVER.IMG_PER_BATCH_UNLABEL 4
    done
fi
