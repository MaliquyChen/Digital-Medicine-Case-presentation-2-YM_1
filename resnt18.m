net18 = resnet18;
imds = dcm2datastore(pwd,'.dcm',0);
labelCount = countEachLabel(imds);
labelCount = labelCount.Count;
min_labelCount = min(labelCount);
train_ratio = 0.7;
numTrainFiles = fix(min_labelCount*train_ratio);
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
layersTransfer = net18.Layers(1:end-3);
numClasses = numel(categories(imdsTrain.Labels))

layers = [
   layersTransfer
   fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
   softmaxLayer
   classificationLayer];
options = trainingOptions('sgdm', ...
    'MiniBatchSize',20, ...
    'MaxEpochs',2, ...
    'InitialLearnRate',1e-3, ...
    'LearnRateSchedule', 'none', ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');
lgraph18 = layerGraph(net18);
lgraph18 = replaceLayer(lgraph18,'fc1000',...
fullyConnectedLayer(3,'Name','fcNew'));
lgraph18 = replaceLayer(lgraph18,'ClassificationLayer_predictions',...
classificationLayer('Name','ClassificationNew'));
layers = lgraph18.Layers;
connections = lgraph18.Connections;
lgraph18 = createLgraphUsingConnections(layers,connections);
tic;
netTransfer18 = trainNetwork(imdsTrain,lgraph18,options);
toc;