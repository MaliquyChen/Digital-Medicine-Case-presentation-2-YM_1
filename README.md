# Digital-Medicine-Case-presentation-2-YM_1
Environment: Matlab 2020a
## Step1: Preprocessing
The **dicompreprocess.m** contant following steps including
1. Image Sharpening (histeq)
2. Gaussian high-pass filter (HPF.m)
3. Iterative graph binarization (Itersplit.m)
4. Marker Connected Area (masker.m)
5. Masking
6. Image resizing
7. **remember to import 'BD2.csv' in this step**
## Step2: Train the CNN model
Three types of models can be trained respectively by **resnet18.m、resnet50.m、resnet101.m**
## Step3: Random forest
The prediction results of the three models are saved as a csv file, imported into matlab, and the Midium tree is generated using the built-in Classification Learner.
## Step4: Generate the validation Data
Use 3 types of resnet to generate prediction results,
1. **remember to import 'BD.csv' in dicompreprocess in this step**
2. Use the code
  yfit = predict(MTree.ClassificationTree,input);
to get the **Final Answer**
