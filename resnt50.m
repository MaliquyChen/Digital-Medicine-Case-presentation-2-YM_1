net50 = resnet50;
imds = dcm2datastore(pwd,'.dcm',0);
labelCount = countEachLabel(imds);
labelCount = labelCount.Count;
min_labelCount = min(labelCount);
train_ratio = 0.7;
numTrainFiles = fix(min_labelCount*train_ratio);
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
layersTransfer = net50.Layers(1:end-3);
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
lgraph50 = layerGraph(net50);
lgraph50 = replaceLayer(lgraph50,'fc1000',...
fullyConnectedLayer(3,'Name','fcNew'));
lgraph50 = replaceLayer(lgraph50,'ClassificationLayer_fc1000',...
classificationLayer('Name','ClassificationNew'));
layers = lgraph50.Layers;
connections = lgraph50.Connections;
lgraph50 = createLgraphUsingConnections(layers,connections);
tic;
netTransfer50 = trainNetwork(imdsTrain,lgraph50,options);
toc;