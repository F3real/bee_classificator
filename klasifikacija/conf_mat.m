function Cm = conf_mat(ctest_hat, ctest, Nclasses)

Cm = zeros(Nclasses);
for j = 1:Nclasses
    for i = 1:Nclasses
        % row i, col j is the percentage of images from class i that
        % were missclassified as class j.
        Cm(i, j) = 100*sum((ctest==i) .* (ctest_hat==j))/sum(ctest==i);
    end
end
