%% ucitavanje oznaka - rucno oznacene

load oznake1
load oznake2
load oznake3
load oznake4
load oznake5
load oznake6
load oznake7
load oznake8
load oznake9
load oznake10
load oznake11
load oznake12
load oznake13
load oznake14
load oznake15
load oznake16
load oznake17
load oznake18
load oznake19
load oznake20

oznake_rucno = cat(1,oznake1,oznake2,oznake3,oznake4,oznake5,oznake6,oznake7,oznake8,oznake9,oznake10,oznake11,...
    oznake12,oznake13,oznake14,oznake15,oznake16,oznake17,oznake18,oznake19,oznake20,2,2);
%% ucitavanje oznaka - predicted

load predicted_labels_1
load predicted_labels_2
load predicted_labels_3
load predicted_labels_4
load predicted_labels_5
load predicted_labels_6
load predicted_labels_7
load predicted_labels_8
load predicted_labels_9
load predicted_labels_10
load predicted_labels_11
load predicted_labels_12
load predicted_labels_13
load predicted_labels_14
load predicted_labels_15
load predicted_labels_16
load predicted_labels_17
load predicted_labels_18
load predicted_labels_19
load predicted_labels_20

oznake_predicted = cat(1,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20);

%% matrica konfuzija
cm_test = conf_mat(oznake_predicted, oznake_rucno, 2)
