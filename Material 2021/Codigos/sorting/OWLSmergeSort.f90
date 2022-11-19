!
! Recursive implementation of the von Neumann's Merge Sort algorithm as
! explained in https://en.wikipedia.org/wiki/Merge_sort
!

SUBROUTINE mergeR(L,sL,R,sR,W,sW)
  USE types,ONLY:I4B,FP
  IMPLICIT NONE
  INTEGER(I4B),INTENT(IN)::sW,sR,sL
  REAL(FP),DIMENSION(sL),INTENT(IN OUT):: L
  REAL(FP),DIMENSION(sW),INTENT(IN OUT):: W
  REAL(FP),DIMENSION(sR),INTENT(IN)::     R
!local
  INTEGER(I4B)::i,j,k

  i=1
  j=1
  k=1
  DO WHILE (i.LE.sL.AND.j.LE.sR)
     IF (L(i).LE.R(j)) THEN
        W(k)=L(i)
        i=i+1
     ELSE
        W(k)=R(j)
        j=j+1
     END IF
     k=k+1
  END DO

  DO WHILE (i.LE.sL)
     W(k)=L(i)
     i=i+1
     k=k+1
  END DO
  RETURN
END SUBROUTINE mergeR

RECURSIVE SUBROUTINE MergeSortR(X,sX,W)
  USE types,ONLY:I4B,FP
  IMPLICIT NONE
  INTEGER(I4B)::sX
  REAL(FP),DIMENSION(sX),INTENT(IN OUT)::    X 
  REAL(FP),DIMENSION((sX+1)/2),INTENT(OUT):: W 
!local
  INTEGER(I4B)::nL,nR 
  REAL(FP):: tmp 

  IF (sX.LT.2) RETURN !!!!!! important step to finish recursive calls
  IF (sX.EQ.2) THEN
     IF (X(1).GT.X(2)) THEN
        tmp=X(1)
        X(1)=X(2)
        X(2)=tmp
     END IF
     RETURN
  END IF

  nL=(sX+1)/2     !!!! divide step
  nR=sX-nL
  CALL MergeSortR(X,nL,W)
  CALL MergeSortR(X(nL+1),nR,W)

  IF (X(nL).GT.X(nL+1)) THEN  !!! conquer step
     W(1:nL)=X(1:nL)
     CALL MergeR(W,nL,X(nL+1),nR,X,sX)
  END IF
  RETURN
END SUBROUTINE MergeSortR


SUBROUTINE mergeI(L,sL,R,sR,W,sW)
  USE types,ONLY:I4B,FP
  IMPLICIT NONE
  INTEGER(I4B),INTENT(IN)::sW,sR,sL
  INTEGER(I4B),DIMENSION(sL),INTENT(IN OUT):: L
  INTEGER(I4B),DIMENSION(sW),INTENT(IN OUT):: W
  INTEGER(I4B),DIMENSION(sR),INTENT(IN)::     R
!local
  INTEGER(I4B)::i,j,k

  i=1
  j=1
  k=1
  DO WHILE (i.LE.sL.AND.j.LE.sR)
     IF (L(i).LE.R(j)) THEN
        W(k)=L(i)
        i=i+1
     ELSE
        W(k)=R(j)
        j=j+1
     END IF
     k=k+1
  END DO

  DO WHILE (i.LE.sL)
     W(k)=L(i)
     i=i+1
     k=k+1
  END DO
  RETURN
END SUBROUTINE mergeI

RECURSIVE SUBROUTINE MergeSortI(X,sX,W)
  USE types,ONLY:I4B,FP
  IMPLICIT NONE
  INTEGER(I4B)::sX
  INTEGER(I4B),DIMENSION(sX),INTENT(IN OUT)::    X 
  INTEGER(I4B),DIMENSION((sX+1)/2),INTENT(OUT):: W 
!local
  INTEGER(I4B)::nL,nR 
  INTEGER(I4B):: tmp 
  
  IF (sX.LT.2) RETURN !!!!!! important step to finish recursive calls
  IF (sX.EQ.2) THEN
     IF (X(1).GT.X(2)) THEN
        tmp=X(1)
        X(1)=X(2)
        X(2)=tmp
     END IF
     RETURN
  END IF

  nL=(sX+1)/2     !!!! divide step
  nR=sX-nL
  CALL MergeSortI(X,nL,W)
  CALL MergeSortI(X(nL+1),nR,W)

  IF (X(nL).GT.X(nL+1)) THEN  !!! conquer step
     W(1:nL)=X(1:nL)
     CALL MergeI(W,nL,X(nL+1),nR,X,sX)
  END IF
  RETURN
END SUBROUTINE MergeSortI



 
! program TestMergeSort
 
!    integer, parameter :: N = 8
!    real*8, dimension(N) :: A = (/ 1., 5., 2., 7., 3., 9., 4., 6. /)
!    real*8, dimension ((N+1)/2) :: T
!    call MergeSort(A,N,T)
!    write(*,*) 'Sorted array :',A
!    write(*,*) 'Sorted array :',T
 
! end program TestMergeSort
