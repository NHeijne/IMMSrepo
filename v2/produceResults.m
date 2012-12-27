coordinateList = [];
resultsDistMS = zeros(length(coordinateList));
resultsTimeMS = zeros(length(coordinateList));
resultsDistBF = zeros(length(coordinateList));
resultsTimeBF = zeros(length(coordinateList));
for i=1:length(coordinateList)
    [resultsDistBF(i), resultsTimeBF(i)] = tracker2(coordinateList(i,:));
    [resultsDistBF(i), resultsTimeBF(i)] = trackerMS(coordinateList(i,:));    
end