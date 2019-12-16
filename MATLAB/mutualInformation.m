function mutualInfo = mutualInformation(counts)

  pXY = counts./sum(counts(:));
  pX = sum(pXY,2);
  pY = sum(pXY,1);

  mutualInfo = pXY.*log(pXY./(pX*pY));
  mutualInfo = sum(mutualInfo(:));

end