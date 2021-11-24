# Digital-Medicine-Case-presentation-2-YM_1
## Step1: Preprocessing
The **dicompreprocess.m** contant following steps including
1. Image Sharpening
2. Gaussian high-pass filter
3. Iterative graph binarization
4. Marker Connected Area
5. Masking
6. Image resizing
## Step2: Train the CNN model
Three types of models can be trained respectively by **resnet18.m、resnet50.m、resnet101.m**
## Step3: Random forest
The prediction results of the three models are saved as a csv file, imported into matlab, and the Midium tree is generated using the built-in Classification Learner.
## Step4: Generate the validation Data
Use 3 types of resnet to generate prediction results,
Use the code
  yfit = predict(MTree.ClassificationTree,input);
to get the **Final Answer**
