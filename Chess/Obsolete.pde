/*
for(int i=0; i<8; i++) for(int j=0; j<8; j++) if(square[i][j].piece != null && !square[i][j].piece.team)
  for(int k=0; k<8; k++) for(int l=0; l<8; l++) if(square[i][j].piece.possible(k,l))
  {
    if(optimal == null) optimal = alphac(i,j,k,l,i,j,k,l,depth-1);
    else
    {
      temp = alphac(i,j,k,l,i,j,k,l,depth-1);
      if(temp.score == optimal.score && random(10) < 1) optimal = temp;
      else if(temp.score > optimal.score) optimal = temp;
    }
  }
  
for(int i=0; i<8; i++) for(int j=0; j<8; j++) if(square[i][j].piece != null && square[i][j].piece.team)
  for(int k=0; k<8; k++) for(int l=0; l<8; l++) if(square[i][j].piece.possible(k,l))
  {
    if(worst == null) worst = betac(i,j,k,l,osx,osy,otx,oty,d-1);
    else
    {
      temp = betac(i,j,k,l,osx,osy,otx,oty,d-1);
      if(temp.score == worst.score && random(10) < 1) worst = temp;
      else if(temp.score < worst.score) worst = temp;
    }
  }

for(int i=0; i<8; i++) for(int j=0; j<8; j++) if(square[i][j].piece != null && !square[i][j].piece.team)
  for(int k=0; k<8; k++) for(int l=0; l<8; l++) if(square[i][j].piece.possible(k,l))
  {
    if(best == null) best = alphac(i,j,k,l,osx,osy,otx,oty,d-1);
    else
    {
      temp = alphac(i,j,k,l,osx,osy,otx,oty,d-1);
      if(temp.score == best.score && random(10) < 1) best = temp;
      else if(temp.score > best.score) best = temp;
    }
  }
*/