function binarizedPosteriors = Posteriors_to_label(posteriors, threshold)

if nargin < 2
  threshold = 0.5;
end

binarizedPosteriors = -ones(1, length(posteriors));

for i = 1:length(posteriors)
    if(posteriors(i)>=threshold) 
        binarizedPosteriors(i) = 1;
    end
end

