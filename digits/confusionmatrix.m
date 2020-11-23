% function M=confusionmatrix(R,T,Cat)
% calculates the conditional distribution P(response-category|target-category)
% INPUT:
% R: responses, 
% T: targets,
% Cat: list of all categories 
% OUTPUT:
% matrix p(response | target)

function M=confusionmatrix(R,T,Cat)
 n=numel(Cat);
 M=zeros(n,n);                      % Distribution of responses per category
 for c=1:n                          % target categories
   for i=1:n                        % levels of response 
     M(c,i)=sum(T==Cat(c) & R==Cat(i)); % count co-occurences 
   end
   M(c,:)=M(c,:)/sum(M(c,:));       % Normalize to obtain conditional distribution
 end
 
end
