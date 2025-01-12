// ###################################################################
// #### This file is part of the mathematics library project, and is
// #### offered under the licence agreement described on
// #### http://www.mrsoft.org/
// ####
// #### Copyright:(c) 2011, Michael R. . All rights reserved.
// ####
// #### Unless required by applicable law or agreed to in writing, software
// #### distributed under the License is distributed on an "AS IS" BASIS,
// #### WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// #### See the License for the specific language governing permissions and
// #### limitations under the License.
// ###################################################################


unit Eigensystems;

// ############################################
// #### Functions to extract eigenvalues and eigenvectors
// ############################################

interface

uses MatrixConst;

// ############################################
// #### functions for nonsymmetric matrices:
// executes the functions below in order to get the result.
function MatrixUnsymEigVecInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; Eivec : PDouble; const LineWidthEivec : TASMNativeInt) : TEigenvalueConvergence;
function MatrixUnsymEigVec(const A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; Eivec : PDouble; const LineWidthEivec : TASMNativeInt) : TEigenvalueConvergence;

function MatrixUnsymEigInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; balance : boolean) : TEigenvalueConvergence;
function MatrixUnsymEig(const A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; balance : boolean) : TEigenvalueConvergence;

// Given a Matrix A[0..width-1][0..Width-1], this routine replaces it by a balanced matrix
// with identical eigenvalues. A symmetric matrix is already balanced and is unaffected by this procedure.
procedure MatrixBalanceInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; Scale : PDouble; const LineWidthScale : TASMNativeInt);
procedure MatrixBalanceBackInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; Scale : PDouble; const LineWidthScale : TASMNativeInt);
// Reduction of Matrix A to hessenberg form by the elimination method. The real, nonsymmetric matrix
// A is replaced by an upper Hessenberg matrix with identical eigenvalues. Recommended, but not
// required, i sthat this routine be preceded by MatrixBalance. Non Hessenberg elements (which should be zero)
// are filled with random values and not replaced by zero elements.
procedure MatrixHessenbergPermInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; perm : PInteger; const LineWidthPerm : TASMNativeInt);
procedure MatrixHessenbergPerm(dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; perm : PInteger; const LineWidthPerm : TASMNativeInt);
procedure MatrixHessenbergInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt);
procedure MatrixHessenberg(dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt);

// copies the hessenberg matrix to dest using the permutation vector from the hessenberg transformation. Initializes the destination matrix for the eigenvector
// finding routine for unsymmetric matrices
procedure MatrixInitEivecHess(hess : PDouble; const LineWidthHess : TASMNativeInt; width : TASMNativeInt; dest : PDouble; const LineWidthDest : TASMNativeInt; perm : PInteger; const LineWidthPerm : TASMNativeInt);

// Finds all eigenvalues of an upper Hessenberg matrix A. On input a can be exactly as output from MatrixHessenberg, on output
// A is destroyed. The real and imaginary parts of the eigenvalues are returned in wr[0..width-1] and wi[0..width-1], respectively
function MatrixEigHessenbergInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt) : TEigenvalueConvergence;
// the following function does not destroy A on output.
function MatrixEigHessenberg(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt) : TEigenvalueConvergence;
// finds all eigenvalues and eigenvectors in an upper hessenberg matrix A. On input A can be exactly as output from MatrixHessenbergPerm, on
// output A is destroyed. For complex eigenvalues (n, n+1) only one eigenvector is stored whereas the real part is stored in vector n and
// the imaginary part is stored in n+1. Note the function does not seem to correctly work with matrices with rank lower than width!
function MatrixEigVecHessenbergInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; Eivec : PDouble; const LineWidthEivec : TASMNativeInt) : TEigenvalueConvergence;
procedure MatrixNormEivecInPlace(Eivec : PDouble; const LineWidthEivec : TASMNativeInt; width : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt);


// ############################################
// #### functions for symmetric matrices:

// Householder reduction of a real, symmetric matrix A[0..width-1][0..width-1]. On output
// A is replaced by the orthogonal matrix Q effecting the transformation. D[0..width-1] returns
// the diagonal elements of the tridiagonal matrix, and e[0..width - 1] of the off-diagonal elements with e[0] = 0.
procedure MatrixTridiagonalHouseInPlace(A : PDouble; const LineWidthA : TASMNativeInt; const width : TASMNativeInt;
  D : PDouble; const LineWidthD : TASMNativeInt; E : PDouble; const LineWidthE : TASMNativeInt);
procedure MatrixTridiagonalHouse(dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; const width : TASMNativeInt;
  D : PDouble; const LineWidthD : TASMNativeInt; E : PDouble; const LineWidthE : TASMNativeInt);

function MatrixTridiagonalQLImplicitInPlace(Z : PDouble; const LineWidthZ : TASMNativeInt; width : TASMNativeInt;
  D : PDouble; const LineWidthD : TASMNativeInt; E : PDouble; const LineWidthE : TASMNativeInt) : TEigenvalueConvergence;

function MatrixEigTridiagonalMatrixInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; EigVals : PDouble; const LineWidthEigVals : TASMNativeInt) : TEigenvalueConvergence;
function MatrixEigTridiagonalMatrix(Dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; EigVals : PDouble; const LineWidthEigVals : TASMNativeInt) : TEigenvalueConvergence;

// ###########################################
// #### Reduction of a real general matrix A to upper Hessenberg form H by
// an orthogonal similarity transformation Q' * A * Q = H
// original DGEHRD

// A: On entry, the N-by-N general matrix to be reduced.
// On exit, the upper triangle and the first subdiagonal of A
// are overwritten with the upper Hessenberg matrix H, and the
// elements below the first subdiagonal, with the array TAU,
// represent the orthogonal matrix Q as a product of elementary
// reflectors. 
function MatrixHessenberg2InPlace(A : PDouble; const LineWidthA : TASMNAtiveInt; width : TASMNativeInt; tau : PDouble; hessBlockSize : integer) : TEigenvalueConvergence; 
function ThrMtxHessenberg2InPlace(A : PDouble; const LineWidthA : TASMNAtiveInt; width : TASMNativeInt; tau : PDouble; hessBlockSize : integer) : TEigenvalueConvergence; 

// generate a real orthogonal matrix Q from the element reflectors (matrixhessenberg2inplace) to
// satisfy Q' * A * Q = H (or Q * H * Q' = A)
// the input matrix A is overwritten by the orhogonal matrix Q
procedure MatrixQFromHessenbergDecomp(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt;
 tau : PDouble; BlockSize : TASMNativeInt; work : PDouble; progress : TLinEquProgress = nil); overload;
procedure MatrixQFromHessenbergDecomp(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt;
 tau : PDouble; progress : TLinEquProgress = nil); overload;

implementation

uses Math, MathUtilFunc, MatrixASMStubSwitch, HouseholderReflectors, types, 
     BlockSizeSetup, ThreadedMatrixOperations, MtxThreadPool,
     LinAlgQR,
     SysUtils;

function MatrixEigTridiagonalMatrixInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; EigVals : PDouble; const LineWidthEigVals : TASMNativeInt) : TEigenvalueConvergence;
var E : Array of double;
begin
     SetLength(E, width);
     MatrixTridiagonalHouseInPlace(A, LineWidthA, width, EigVals, LineWidthEigVals, @E[0], sizeof(double));
     Result := MatrixTridiagonalQLImplicitInPlace(A, LineWidthA, width, EigVals, LineWidthEigVals, @E[0], sizeof(double));
end;

function MatrixEigTridiagonalMatrix(Dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; EigVals : PDouble; const LineWidthEigVals : TASMNativeInt) : TEigenvalueConvergence;
var E : Array of double;
begin
     SetLength(E, width);
     MatrixTridiagonalHouse(dest, LineWidthDest, A, LineWidthA, width, EigVals, LineWidthEigVals, @E[0], sizeof(double));
     Result := MatrixTridiagonalQLImplicitInPlace(dest, LineWidthDest, width, EigVals, LineWidthEigVals, @E[0], sizeof(double));
end;

procedure MatrixTridiagonalHouse(dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; const width : TASMNativeInt;
  D : PDouble; const LineWidthD : TASMNativeInt; E : PDouble; const LineWidthE : TASMNativeInt);
var pDest : PDouble;
    i : TASMNativeInt;
begin
     Assert(width > 0, 'Dimension Error');
     Assert(LineWidthA >= width*sizeof(double), 'Dimension error');
     Assert(LineWidthD >= sizeof(double), 'Dimension error');
     Assert(LineWidthE >= sizeof(double), 'Dimension error');

     pDest := dest;
     // copy data -> now we can perform an inline LU decomposition
     for i := 0 to width - 1 do
     begin
          Move(A^, pDest^, sizeof(double)*width);
          inc(PByte(A), LineWidthA);
          inc(PByte(pDest), LineWidthDest);
     end;

     MatrixTridiagonalHouseInPlace(dest, LineWidthDest, width, D, LineWidthD, E, LineWidthE);
end;

procedure MatrixTridiagonalHouseInPlace(A : PDouble; const LineWidthA : TASMNativeInt; const width : TASMNativeInt;
  D : PDouble; const LineWidthD : TASMNativeInt; E : PDouble; const LineWidthE : TASMNativeInt);
var i, j : TASMNativeInt;
    l, k : TASMNativeInt;
    scale, hh, h, g, f : double;
    pA, pAi, pAj, pAk : PDouble;
    pEi, pEj, pEk : PDouble;
    pD : PDouble;
begin
     Assert(width > 0, 'Dimension Error');
     Assert(LineWidthA >= width*sizeof(double), 'Dimension error');
     Assert(LineWidthD >= sizeof(double), 'Dimension error');
     Assert(LineWidthE >= sizeof(double), 'Dimension error');

     pAi := A;
     inc(PByte(pAi), (width-1)*LineWidthA);
     pEi := E;
     inc(PByte(pEi), (width-1)*LineWidthE);
     for i := width - 1 downto 1 do
     begin
          l := i - 1;
          h := 0;
          scale := 0;

          if l > 0 then
          begin
               pA := pAi;

               for k := 0 to l do
               begin
                    scale := scale + abs(pA^);
                    inc(pA);
               end;

               if scale = 0 then
               begin
                    // skip transformation
                    dec(pA);
                    pEi^ := pA^;
               end
               else
               begin
                    pA := pAi;

                    for k := 0 to l do
                    begin
                         pA^ := pA^/scale;  // use scaled a's for transformation
                         h := h + sqr(pA^);
                         inc(pA);
                    end;

                    dec(pA);
                    f := pA^;
                    if f >= 0
                    then
                        g := -sqrt(h)
                    else
                        g := sqrt(h);

                    pEi^ := scale*g;
                    h := h - f*g;
                    pA^ := f - g;   // store u in the ith row of a

                    f := 0;

                    pAj := A;
                    pEj := E;
                    for j := 0 to l do
                    begin
                         pA := pAj;
                         inc(pA, i);
                         pAk := pAi;
                         inc(pAk, j);

                         // next statement can be omitted if eigenvectors not wanted
                         pA^ := pAk^/h;   // store u/H in ith column of a.
                         g := 0;

                         // Form an element of A*u in g
                         pAk := pAj;
                         pA := pAi;
                         for k := 0 to j do
                         begin
                              g := g + pA^*pAk^;
                              inc(pAk);
                              inc(pA);
                         end;
                         pAk := pAj;
                         pA := pAi;
                         inc(pA, j + 1);
                         inc(PByte(pAk), LineWidthA);
                         inc(pAk, j);
                         for k := j + 1 to l do
                         begin
                              g := g + pA^*pAk^;
                              inc(PByte(pAk), LineWidthA);
                              inc(pA);
                         end;

                         pEj^ := g/h;

                         pA := pAi;
                         inc(pA, j);
                         f := f + pEj^*pA^;

                         // next line
                         inc(PByte(pEj), LineWidthE);
                         inc(PByte(pAj), LineWidthA);
                    end;

                    hh := f/(h + h);

                    pAj := A;
                    pEj := E;
                    for j := 0 to l do
                    begin
                         pA := pAi;
                         inc(pA, j);

                         f := pA^;
                         pEj^ := pEj^ - hh*f;
                         g := pEj^;

                         pAk := pAj;
                         pEk := E;
                         pA := pAi;
                         for k := 0 to j do
                         begin
                              pAk^ := pAk^ - (f*pEk^ + g*pA^);
                              inc(pA);
                              inc(pAk);
                              inc(PByte(pEk), LineWidthE);
                         end;

                         inc(PByte(pAj), LineWidthA);
                         inc(PByte(pEj), LineWidthE);
                    end;
               end;
          end
          else
          begin
               pA := pAi;
               inc(pA, l);
               pEi^ := pA^;
          end;

          pD := D;
          inc(PByte(pD), i*LineWidthD);
          pD^ := h;

          dec(PByte(pAi), LineWidthA);
          dec(PByte(pEi), LineWidthE);
     end;

     // next statement can be omitted if eigenvectors not wanted
     D^ := 0;
     E^ := 0;

     // contents of this loop can be omitted if eigenvectors not wanted except for statement d[i] = a[i][i]

     // begin accumulation of transformation matrices.
     pAi := A;
     pD := D;
     for i := 0 to width - 1 do
     begin
          l := i - 1;
          if (pD^ <> 0) then
          begin
               for j := 0 to l do
               begin
                    g := 0;

                    pA := pAi;
                    pAk := A;
                    inc(pAk, j);
                    for k := 0 to l do
                    begin
                         g := g + pA^*pAk^;
                         inc(pA);
                         inc(PByte(pAk), LineWidthA);
                    end;

                    pA := A;
                    inc(pA, j);
                    pAk := A;
                    inc(pAk, i);
                    for k := 0 to l do
                    begin
                         pA^ := pA^ - g*pAk^;
                         inc(PByte(pA), LineWidthA);
                         inc(PByte(pAk), LineWidthA);
                    end;
               end;
          end;

          pA := pAi;
          inc(pA, i);
          pD^ := pA^;
          pA^ := 1;

          pAj := A;
          inc(pAj, i);
          pA := pAi;

          for j := 0 to l do
          begin
               pAj^ := 0;
               pA^ := 0;

               inc(PByte(pAj), LineWidthA);
               inc(pA);
          end;

          inc(PByte(pAi), LineWidthA);
          inc(PByte(pD), LineWidthD);
     end;
end;

function MatrixTridiagonalQLImplicitInPlace(Z : PDouble; const LineWidthZ : TASMNativeInt; width : TASMNativeInt;
  D : PDouble; const LineWidthD : TASMNativeInt; E : PDouble; const LineWidthE : TASMNativeInt) : TEigenvalueConvergence;
var m, l, iter, i, k : TASMNativeInt;
    s, r, p, g, f, dd, c, b : double;
    pE, pEl, pEi : PDouble;
    pD, pDl : PDouble;
    pZ, pZi : PDouble;
const cMaxTridiagIter = 30;
begin
     pE := E;
     pEi := E;
     inc(PByte(pEi), LineWidthE);

     Result := qlNoConverge;

     for i := 1 to width - 1 do
     begin
          pE^ := pEi^;
          inc(PByte(pE), LineWidthE);
          inc(PByte(pEi), LineWidthE);
     end;

     pE := E;
     inc(PByte(pE), (width - 1)*LineWidthE);
     pE^ := 0;

     pDl := D;
     pEl := E;
     for l := 0 to width - 1 do
     begin
          iter := 0;

          repeat
                pD := pDl;
                pE := pEl;
                m := l;
                while m < width - 1 do
                begin
                     dd := abs(pD^);
                     inc(PByte(pD), LineWidthD);
                     dd := dd + abs(pD^);

                     if pE^ + dd = dd then
                        break;

                     inc(PByte(pE), LineWidthE);
                     inc(m);
                end;

                if m <> l then
                begin
                     inc(iter);
                     if iter = cMaxTridiagIter then
                        exit;

                     g := (PDouble(TASMNativeUInt(pDl) + TASMNativeUInt(LineWidthD))^ - pDl^)/(2*pEl^);
                     r := pythag(g, 1);
                     pD := D;
                     inc(PByte(pD), m*LineWidthD);
                     g := pD^ - pDl^ + pEl^/(g + sign(r, g));
                     s := 1;
                     c := 1;
                     p := 0;

                     pE := E;
                     inc(PByte(pE), (m - 1)*LineWidthE);
                     for i := m - 1 downto l do
                     begin
                          f := s*pE^;
                          b := c*pE^;
                          r := pythag(f, g);

                          inc(PByte(pE), LineWidthE);
                          pE^ := r;

                          if r = 0 then
                          begin
                               pD^ := pD^ - p;
                               pE := E;
                               inc(PByte(pE), m*LineWidthE);
                               pE^ := 0;

                               break;
                          end;

                          s := f/r;
                          c := g/r;
                          g := pD^ - p;
                          dec(PByte(pD), LineWidthD);
                          r := (pD^ - g)*s + 2*c*b;
                          p := s*r;
                          inc(PByte(pD), LineWidthD);
                          pD^ := g + p;
                          g := c*r - b;

                          // next loop can be omitted if eigenvectors not wanted
                          pZ := Z;
                          pZi := Z;
                          inc(pZ, i);
                          inc(pZi, i+1);
                          for k := 0 to width - 1 do
                          begin
                               f := pZi^;
                               pZi^ := s*pZ^ + c*f;
                               pZ^ := c*pZ^ - s*f;

                               inc(PByte(pZi), LineWidthZ);
                               inc(PByte(pZ), LineWidthZ);
                          end;

                          dec(PByte(pD), LineWidthD);
                          dec(PByte(pE), 2*LineWidthE);
                     end;

                     if (r = 0) and (i >= l) then
                        continue;

                     pDl^ := pDl^ - p;
                     pEl^ := g;
                     pE := E;
                     inc(PByte(pE), m*LineWidthE);
                     pE^ := 0;
                end;
          until m = l;

          inc(PByte(pDl), LineWidthD);
          inc(PByte(pEl), LineWidthE);
     end;

     Result := qlOk;
end;

procedure MatrixBalanceBackInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; Scale : PDouble; const LineWidthScale : TASMNativeInt);
var i : TASMNativeInt;
begin
     for i := 0 to width - 1 do
     begin
          if Scale^ <> 1 then
          begin
               // Apply similarity transformation
               MatrixScaleAndAdd( GenPtr(A, 0, i, LineWidthA), LineWidthA, width, 1, 0, Scale^ );
               MatrixScaleAndAdd( GenPtr(A, i, 0, LineWidthA), LineWidthA, 1, width, 0, 1/Scale^ );
          end;

          inc(PByte(Scale), LineWidthScale);
     end;
end;

procedure MatrixBalanceInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; Scale : PDouble; const LineWidthScale : TASMNativeInt);
var j, i : TASMNativeInt;
    last : boolean;
    s, r, g, f, c, sqrdx : double;
    pAi : PConstDoubleArr;
    pAj, pScale : PDouble;
const RADIX = 2.0;
begin
     assert(lineWidthA >= width*sizeof(double), 'Dimension error');
     assert(LineWidthScale >= sizeof(double), 'Dimension error');

     sqrdx := sqr(RADIX);
     last := False;

     MatrixInit(scale, LineWidthScale, 1, width, 1);
     
     while last = False do
     begin
          last := True;

          pScale := Scale;
          for i := 0 to width - 1 do
          begin
               r := 0;
               c := 0;

               pAi := GenPtrArr(A, 0, i, LineWidthA);
               pAj := GenPtr(A, i, 0, LineWidthA);
               for j := 0 to width - 1 do
               begin
                    if i <> j then
                    begin
                         c := c + abs(pAj^);
                         r := r + abs(pAi^[j]);
                    end;

                    inc(PByte(pAj), LineWidthA);
               end;

               if (c <> 0) and (r <> 0) then
               begin
                    g := r/RADIX;
                    f := 1;
                    s := c + r;

                    // find the integer power of the machine radix that comes closest to balancing the matrix.
                    while c < g do
                    begin
                         f := f*RADIX;
                         c := c*sqrdx;
                    end;
                    g := r*RADIX;
                    while c > g do
                    begin
                         f := f/RADIX;
                         c := c/sqrdx;
                    end;

                    if (c + r)/f < 0.95*s then
                    begin
                         pScale^ := pScale^*f;
                         last := False;
                         g := 1/f;

                         // Apply similarity transformation
                         MatrixScaleAndAdd( GenPtr(A, 0, i, LineWidthA), LineWidthA, width, 1, 0, g );
                         MatrixScaleAndAdd( GenPtr(A, i, 0, LineWidthA), LineWidthA, 1, width, 0, f );
                    end;
               end;

               inc(PByte(pScale), LineWidthScale);
          end;
     end;
end;

procedure MatrixHessenbergPerm(dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; perm : PInteger; const LineWidthPerm : TASMNativeInt);
begin
     assert(LineWidthA >= width*sizeof(double), 'Dimension Error');
     assert(LineWidthDest >= width*sizeof(double), 'Dimension Error');

     MatrixCopy(Dest, LineWidthDest, A, LineWidthA, width, width);
     MatrixHessenbergPermInPlace(dest, LineWidthDest, width, perm, LineWidthPerm);
end;

procedure MatrixHessenbergPermInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; perm : PInteger; const LineWidthPerm : TASMNativeInt);
var m, j, i : TASMNativeInt;
    x, y : double;
    pAm, pAj, pAi : PDouble;
    pA : PDouble;
    pPerm : PInteger;
begin
     assert(LineWidthA >= width*sizeof(double), 'Dimension Error');
     pAm := A;
     pPerm := Perm;
     if Assigned(pPerm) then
     begin
          pPerm^ := 0;
          inc(PByte(pPerm), LineWidthPerm);
     end;
     m := 1;
     while m < width - 1 do
     begin
          inc(PByte(pAm), LineWidthA);
          x := 0;
          i := m;

          // find the pivot
          pAj := pAm;
          inc(pAj, m - 1);
          for j := m to width - 1 do
          begin
               if abs(pAj^) > abs(x) then
               begin
                    x := pAj^;
                    i := j;
               end;

               inc(PByte(pAj), LineWidthA);
          end;

          if Assigned(pPerm) then
          begin
               pPerm^ := i;
               inc(PByte(pPerm), LineWidthPerm);
          end;

          // interchange rows and columns
          if i <> m then
          begin
               pAi := A;
               inc(pAi, m - 1);
               inc(PByte(pAi), i*LineWidthA);
               pAj := pAm;
               inc(pAj, m - 1);
               for j := m - 1 to width - 1 do
               begin
                    DoubleSwap(pAi^, pAj^);
                    inc(pAj);
                    inc(pAi);
               end;

               pAi := A;
               inc(pAi, i);
               pAj := A;
               inc(pAj, m);
               for j := 0 to width - 1 do
               begin
                    DoubleSwap(pAi^, pAj^);
                    inc(PByte(pAi), LineWidthA);
                    inc(PByte(pAj), LineWidthA);
               end;
          end;

          // carry out the elimination
          if x <> 0 then
          begin
               pA := pAm;
               inc(PByte(pA), LineWidthA);
               inc(pA, m - 1);
               i := m + 1;
               while i < width do
               begin
                    y := pA^;
                    if y <> 0 then
                    begin
                         y := y/x;

                         pA^ := y;

                         pAi := A;
                         inc(pAi, m);
                         inc(PByte(pAi), i*LineWidthA);
                         pAj := pAm;
                         inc(pAj, m);
                         for j := m to width - 1 do
                         begin
                              pAi^ := pAi^ - y*pAj^;
                              inc(pAj);
                              inc(pAi);
                         end;

                         pAi := A;
                         inc(pAi, i);
                         pAj := A;
                         inc(pAj, m);
                         for j := 0 to width - 1 do
                         begin
                              pAj^ := pAj^ + y*pAi^;
                              inc(PByte(pAi), LineWidthA);
                              inc(PByte(pAj), LineWidthA);
                         end;
                    end;

                    inc(PByte(pA), LineWidthA);
                    inc(i);
               end;
          end;

          inc(m);
     end;
end;

function MatrixEigHessenberg(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt) : TEigenvalueConvergence;
var pDest : PDouble;
    dest : Array of double;
    i : TASMNativeInt;
begin
     Assert(width > 0, 'Dimension Error');
     Assert(LineWidthA >= width*sizeof(double), 'Dimension error');

     setLength(dest, width*width);

     pDest := @dest[0];

     // copy data 
     for i := 0 to width - 1 do
     begin
          Move(A^, pDest^, sizeof(double)*width);
          inc(PByte(A), LineWidthA);
          inc(PByte(pDest), width*sizeof(double));
     end;

     Result := MatrixEigHessenbergInPlace(@dest[0], width*sizeof(double), width, WR, LineWidthWR, WI, LineWidthWI);
end;

function MatrixEigHessenbergInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt) : TEigenvalueConvergence;
var nn, m, l, k : TASMNativeInt;
    j, its, i, mmin : TASMNativeInt;
    x, y, z : double;
    u, v, w : double;
    r, s, t : double;
    q, p, anorm : double;
    pAi, pAj, pAl, pA, pAm, pAk : PDouble;
    pWr : PDouble;
    pWi : PDouble;
const cMaxEigHessenbergIter = 30;
begin
     Assert(width > 0, 'Dimension Error');
     Assert(LineWidthA >= width*sizeof(double), 'Dimension error');
     Assert(LineWidthWR >= sizeof(double), 'Dimension error');
     Assert(LineWidthWI >= sizeof(double), 'Dimension error');

     r := 0;
     p := 0;
     q := 0;
     Result := qlNoConverge;
     anorm := abs(A^);
     pAi := A;
     inc(PByte(pAi), LineWidthA);
     // compute matrix norm for possible use in locating single small subdiagonal element
     for i := 1 to width - 1 do
     begin
          pAj := pAi;
          inc(pAj, i - 1);
          for j := i - 1 to width - 1 do
          begin
               anorm := anorm + abs(pAj^);

               inc(pAj);
          end;

          inc(PByte(pAi), LineWidthA);
     end;

     nn := width - 1;
     t := 0;
     // gets changed only by an exceptional shift.
     while nn >= 0 do
     begin
          // begin search of the next eigenvalue
          its := 0;
          repeat
                // begin iteration: look for single small subdiagonal element.
                pAl := A;
                inc(pAl, nn);
                inc(PByte(pAl), nn*LineWidthA);
                l := nn;
                while l >= 1 do
                begin
                     s := abs(pAl^);
                     dec(pAl);
                     dec(PByte(pAl), LineWidthA);
                     s := s + abs(pAl^);

                     if s = 0 then
                        s := anorm;

                     inc(PByte(pAl), LineWidthA);
                     if abs(pAl^) + s = s then
                        break;

                     dec(PByte(pAl), LineWidthA);
                     dec(l);
                end;

                pA := A;
                inc(pA, nn);
                inc(PByte(pA), nn*LineWidthA);
                x := pA^;
                // one root found
                if l = nn then
                begin
                     pWr := WR;
                     inc(PByte(pWr), nn*LineWidthWR);
                     pWr^ := x + t;
                     pWi := WI;
                     inc(PByte(pWi), nn*LineWidthWI);
                     pWi^ := 0;
                     dec(nn);
                end
                else
                begin
                     dec(pA);
                     dec(PByte(pA), LineWidthA);
                     y := pA^;
                     inc(pA);
                     w := pA^;
                     dec(pA);
                     inc(PByte(pA), LineWidthA);
                     w := w*pA^;
                     // two roots found ...
                     if l = nn - 1 then
                     begin
                          p := 0.5*(y - x);
                          q := sqr(p) + w;
                          z := sqrt(abs(q));
                          x := x + t;

                          pWr := WR;
                          inc(PByte(pWr), (nn-1)*LineWidthWR);
                          pWi := WI;
                          inc(PByte(pWi), (nn-1)*LineWidthWI);
                          // ... a real pair
                          if q >= 0 then
                          begin
                               z := p + sign(z, p);

                               pWr^ := x + z;
                               inc(PByte(pWr), LineWidthWR);
                               pWr^ := x + z;
                               if z <> 0 then
                                  pWr^ := x - w/z;

                               pWi^ := 0;
                               inc(PByte(pWi), LineWidthWI);
                               pWi^ := 0;
                          end
                          else
                          begin
                               // ...a complex pair
                               pWr^ := x + p;
                               inc(PByte(pWr), LineWidthWR);
                               pWr^ := x + p;
                               pWi^ := -z;
                               inc(PByte(pWi), LineWidthWI);
                               pWi^ := z;
                          end;

                          dec(nn, 2);
                     end
                     else
                     begin
                          // no roots found. Continue iteration
                          if its = cMaxEigHessenbergIter then
                             exit;

                          // form exceptional shift
                          if (its = 10) or (its = 20) then
                          begin
                               t := t + x;
                               pAi := A;
                               for i := 0 to width - 1 do
                               begin
                                    pAi^ := pAi^ - x;
                                    inc(pAi);
                                    inc(PByte(pAi), LineWidthA);
                               end;

                               pA := A;
                               inc(pA, nn - 1);
                               inc(PByte(pA), nn*LineWidthA);
                               s := abs(pA^);
                               dec(pA);
                               dec(PByte(pA), LineWidthA);
                               s := s + abs(pA^);
                               x := 0.75*s;
                               y := x;
                               w := -0.4375*sqr(s);
                          end;
                          inc(its);

                          // form shift and the look for 2 consecutive small subdiagonal elements
                          pAm := A;
                          inc(pAm, nn - 2);
                          inc(PByte(pAm), (nn - 2)*LineWidthA);
                          m := nn - 2;
                          while m >= l do
                          begin
                               z := pAm^;
                               r := x - z;
                               s := y - z;

                               pAi := pAm;
                               inc(pAi);
                               pAl := pAm;
                               inc(PByte(pAl), LineWidthA);
                               p := (r*s - w)/pAl^ + pAi^;
                               inc(pAl);
                               q := pAl^ - z - r - s;
                               inc(PByte(pAl), LineWidthA);
                               r := pAl^;
                               // scale to prevent under- or overflow
                               s := abs(p) + abs(q) + abs(r);
                               p := p/s;
                               q := q/s;
                               r := r/s;

                               if m = l then
                                  break;

                               pAi := pAm;
                               dec(pAi);
                               u := abs(pAi^)*(abs(q) + abs(r));
                               dec(PByte(pAi), LineWidthA);
                               dec(PByte(pAl), LineWidthA);
                               v := abs(p)*(abs(pAi^) + abs(z) + abs(pAl^));

                               if u + v = v then
                                  break;

                               dec(pAm);
                               dec(PByte(pAm), LineWidthA);
                               dec(m);
                          end;

                          pAi := A;
                          inc(pAi, m);
                          inc(PByte(pAi), (m + 2)*LineWidthA);
                          for i := m + 2 to nn do
                          begin
                               pAi^ := 0;
                               if i <> m + 2 then
                               begin
                                    dec(pAi);
                                    pAi^ := 0;
                                    inc(pAi);
                               end;

                               inc(pAi);
                               inc(PByte(pAi), LineWidthA);
                          end;

                          // double QR step on rows l to nn and columns m to nn
                          pAk := A;
                          inc(pAk, m - 1);
                          inc(PByte(pAk), m*LineWidthA);
                          for k := m to nn - 1 do
                          begin
                               if k <> m then
                               begin
                                    p := pAk^;
                                    inc(PByte(pAk), LineWidthA);
                                    q := pAk^;
                                    r := 0;
                                    if k <> nn - 1 then
                                    begin
                                         inc(PByte(pAk), LineWidthA);
                                         r := pAk^;
                                         dec(PByte(pAk), LineWidthA);
                                    end;

                                    x := abs(p) + abs(q) + abs(r);
                                    if x <> 0 then
                                    begin
                                         p := p/x;
                                         q := q/x;
                                         r := r/x;
                                    end;
                                    dec(PByte(pAk), LineWidthA);
                               end;

                               s := sign(sqrt(sqr(p) + sqr(q) + sqr(r)), p);
                               if s <> 0 then
                               begin
                                    if k = m then
                                    begin
                                         if l <> m then
                                            pAk^ := -pAk^;
                                    end
                                    else
                                        pAk^ := -s*x;

                                    p := p + s;
                                    x := p/s;
                                    y := q/s;
                                    z := r/s;
                                    q := q/p;
                                    r := r/p;

                                    // Row modification
                                    pAj := pAk;
                                    inc(pAj);
                                    for j := k to nn do
                                    begin
                                         p := pAj^;
                                         inc(PByte(pAj), LineWidthA);
                                         p := p + q*pAj^;

                                         if k <> nn - 1 then
                                         begin
                                              inc(PByte(pAj), LineWidthA);
                                              p := p + r*pAj^;
                                              pAj^ := pAj^ - p*z;
                                              dec(PByte(pAj), LineWidthA);
                                         end;

                                         pAj^ := pAj^ - p*y;
                                         dec(PByte(pAj), LineWidthA);
                                         pAj^ := pAj^ - p*x;
                                         inc(pAj);
                                    end;

                                    // column modification
                                    if nn < k + 3
                                    then
                                        mmin := nn
                                    else
                                        mmin := k + 3;
                                    pAi := A;
                                    inc(pAi, k);
                                    inc(PByte(pAi), l*LineWidthA);
                                    for i := l to mmin do
                                    begin
                                         p := x*pAi^;
                                         inc(pAi);
                                         p := p + y*pAi^;
                                         if k <> nn - 1 then
                                         begin
                                              inc(pAi);
                                              p := p + z*pAi^;
                                              pAi^ := pAi^ - p*r;
                                              dec(pAi);
                                         end;
                                         pAi^ := pAi^ - p*q;
                                         dec(pAi);
                                         pAi^ := pAi^ - p;
                                         inc(PByte(pAi), LineWidthA);
                                    end;
                               end;

                               inc(pAk);
                               inc(PByte(pAk), LineWidthA);
                          end;
                     end;
                end;
          until l >= nn - 1;
     end;

     Result := qlOk;
end;

procedure MatrixInitEivecHess(hess : PDouble; const LineWidthHess : TASMNativeInt; width : TASMNativeInt; dest : PDouble; const LineWidthDest : TASMNativeInt; perm : PInteger; const LineWidthPerm : TASMNativeInt);
var i, j, k : TASMNativeInt;
    pDest, pDesti, pDestj : PDouble;
    pPerm : PInteger;
    pHess : PDouble;
    mp : TASMNativeInt;
begin
     pPerm := Perm;
     inc(PByte(pPerm), (width - 2)*LineWidthPerm);
     for mp := width - 2 downto 1 do
     begin
          pDest := dest;
          inc(PByte(pDest), (mp + 1)*LineWidthDest);
          inc(pDest, mp);

          pHess := hess;
          inc(PByte(pHess), (mp + 1)*LineWidthHess);
          inc(pHess, mp - 1);
          
          
          for k := mp + 1 to width - 1 do
          begin
               pDest^ := pHess^;
               inc(PByte(pDest), LineWidthDest);
               inc(PByte(pHess), LineWidthHess);
          end;

          i := pPerm^;

          if i <> mp then
          begin
               pDestj := Dest;
               inc(PByte(PDestj), mp*LineWidthDest);
               inc(pDestj, mp);

               pDesti := Dest;
               inc(PByte(PDesti), i*LineWidthDest);
               inc(pDesti, mp);
               for j := mp to width - 1 do
               begin
                    pDestj^ := pDesti^;
                    pDesti^ := 0;
                    inc(pDestj);
                    inc(pDesti);
               end;
               pDesti := Dest;
               inc(PByte(PDesti), i*LineWidthDest);
               inc(pDesti, mp);
               pDesti^ := 1;
          end;

          dec(PByte(pPerm), LineWidthPerm);
     end;
end;

procedure Cdiv(const Ar, Ai, Br, Bi : double; var Cr, Ci : double); {$IFNDEF FPC} {$IF CompilerVersion >= 17.0} inline; {$IFEND} {$ENDIF}
{ Complex division, (Cr,Ci) = (Ar,Ai)/(Br,Bi) }
var tmp : double;
    brt : double;
    bit : double;
begin
     if abs(br) > abs(bi) then
     begin
          tmp := bi / br;
          brt := tmp * bi + br;
          cr := (ar + tmp * ai) / brt;
          ci := (ai - tmp * ar) / brt
     end
     else
     begin
          tmp := br / bi;
          bit := tmp * br + bi;
          cr := (tmp * ar + ai) / bit;
          ci := (tmp * ai - ar) / bit
    end;
end;

function CAbs(ar, ai : double) : double; {$IFNDEF FPC} {$IF CompilerVersion >= 17.0} inline; {$IFEND} {$ENDIF}
var tmp : double;
begin
     if (ar = 0) and (ai = 0) then
     begin
          Result := 0;
          exit;
     end;

     ar := ABS(ar);
     ai := ABS(ai);

     if ai > ar then
     begin
          tmp := ai;
          ai := ar;
          ar := tmp;
     end;

     if ai = 0
     then
         Result := ar
     else
         Result := ar * Sqrt(1 + ai / ar * ai / ar);
end;

procedure MatrixNormEivecInPlace(Eivec : PDouble; const LineWidthEivec : TASMNativeInt; width : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt);
var i, j : TASMNativeInt;
    pWi : PDouble;
    pEivec, pEiveci, pEivecj : PDouble;
    maxVal : double;
    tr, ti : double;
begin
     assert(width > 0, 'Dimension error');
     assert(width*sizeof(Double) <= LineWidthEivec, 'Dimension error');
     assert(LineWidthWI >= sizeof(double), 'Dimension error');

     pWi := WI;
     pEivec := Eivec;
     j := 0;
     while j < width do
     begin
          if pWi^ = 0 then
          begin
               maxVal := pEivec^;

               pEiveci := pEivec;
               inc(PByte(pEiveci), LineWidthEivec);
               for i := 1 to width - 1 do
               begin
                    if abs(pEiveci^) > abs(maxVal) then
                       maxVal := pEiveci^;

                    inc(PByte(pEiveci), LineWidthEivec);
               end;

               if maxVal <> 0 then
               begin
                    maxVal := 1/maxVal;
                    pEiveci := pEivec;
                    for i := 0 to width - 1 do
                    begin
                         pEiveci^ := maxVal*pEiveci^;
                         inc(PByte(pEiveci), LineWidthEivec);
                    end;
               end;
          end
          else
          begin
               pEiveci := pEivec;
               pEivecj := pEivec;
               inc(pEivecj);

               tr := pEiveci^;
               ti := pEivecj^;

               inc(PByte(pEiveci), LineWidthEivec);
               inc(PByte(pEivecj), LineWidthEivec);

               for i := 1 to width - 1 do
               begin
                    if CAbs(pEiveci^, pEivecj^) > CAbs(tr, ti) then
                    begin
                         tr := pEiveci^;
                         ti := pEivecj^;
                    end;

                    inc(PByte(pEiveci), LineWidthEivec);
                    inc(PByte(pEivecj), LineWidthEivec);
               end;

               if (tr <> 0) and (ti <> 0) then
               begin
                    pEiveci := pEivec;
                    pEivecj := pEivec;
                    inc(pEivecj);
                    for i := 0 to width - 1 do
                    begin
                         CDiv(pEiveci^, pEivecj^, tr, ti, pEiveci^, pEivecj^);
                         inc(PByte(pEiveci), LineWidthEivec);
                         inc(PByte(pEivecj), LineWidthEivec);
                    end;
               end;
               inc(pEivec);
               inc(PByte(pWi), LineWidthWI);
               inc(j);
          end;

          inc(pEivec);
          inc(PByte(pWi), LineWidthWI);
          inc(j);
     end;
end;

function MatrixEigVecHessenbergInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; Eivec : PDouble; const LineWidthEivec : TASMNativeInt) : TEigenvalueConvergence;
var nn, m, l, k : TASMNativeInt;
    j, its, i, mmin : TASMNativeInt;
    x, y, z : double;
    u, v, w : double;
    r, s, t : double;
    q, p, anorm : double;
    ra, sa : double;
    pAi, pAj, pAl, pA, pAm, pAk : PDouble;
    pEivecj, pEiveck, pEiveci : PDouble;
    pWr, pWri : PDouble;
    pWi, pWii : PDouble;
    vr : double;
    vi : double;
    na : TASMNativeInt;
const cMaxEigHessenbergIter = 30;
      cEPS = 2.22e-16;
begin
     Assert(width > 0, 'Dimension Error');
     Assert(LineWidthA >= width*sizeof(double), 'Dimension error');
     Assert(LineWidthEivec >= width*sizeof(double), 'Dimension error');
     Assert(LineWidthWR >= sizeof(double), 'Dimension error');
     Assert(LineWidthWI >= sizeof(double), 'Dimension error');

     r := 0;
     p := 0;
     q := 0;
     Result := qlNoConverge;
     anorm := 0;
     pAi := A;
     // compute matrix norm for possible use in locating single small subdiagonal element
     for i := 0 to width - 1 do
     begin
          pAj := pAi;
          inc(pAj, max(0, i - 1));
          for j := Max(0, i - 1) to width - 1 do
          begin
               anorm := anorm + abs(pAj^);

               inc(pAj);
          end;

          inc(PByte(pAi), LineWidthA);
     end;

     if anorm = 0 then
     begin
          Result := qlMatrixError;
          exit;
     end;
     
     nn := width - 1;
     t := 0;
     // gets changed only by an exceptional shift.
     while nn >= 0 do
     begin
          // begin search of the next eigenvalue
          its := 0;
          repeat
                // begin iteration: look for single small subdiagonal element.
                pAl := A;
                inc(pAl, nn);
                inc(PByte(pAl), nn*LineWidthA);
                l := nn;
                while l >= 1 do
                begin
                     s := abs(pAl^);
                     dec(pAl);
                     dec(PByte(pAl), LineWidthA);
                     s := s + abs(pAl^);

                     if s = 0 then
                        s := anorm;

                     inc(PByte(pAl), LineWidthA);

                     if abs(pAl^) <= cEPS*s then
                     begin
                          pAl^ := 0;
                          break;
                     end;

                     dec(PByte(pAl), LineWidthA);
                     dec(l);
                end;

                pA := A;
                inc(pA, nn);
                inc(PByte(pA), nn*LineWidthA);
                x := pA^;
                // one root found
                if l = nn then
                begin
                     pWr := WR;
                     inc(PByte(pWr), nn*LineWidthWR);
                     pWr^ := x + t;
                     pA^ := pWr^;
                     pWi := WI;
                     inc(PByte(pWi), nn*LineWidthWI);
                     pWi^ := 0;
                     dec(nn);
                end
                else
                begin
                     dec(pA);
                     dec(PByte(pA), LineWidthA);
                     y := pA^;
                     inc(pA);
                     w := pA^;
                     dec(pA);
                     inc(PByte(pA), LineWidthA);
                     w := w*pA^;
                     // two roots found ...
                     if l = nn - 1 then
                     begin
                          p := 0.5*(y - x);
                          q := sqr(p) + w;
                          z := sqrt(abs(q));
                          x := x + t;

                          pA := A;
                          inc(pA, nn);
                          inc(PByte(pA), nn*LineWidthA);
                          pA^ := x;
                          dec(pA);
                          dec(PByte(pA), LineWidthA);
                          pA^ := y + t;

                          pWr := WR;
                          inc(PByte(pWr), (nn - 1)*LineWidthWR);
                          pWi := WI;
                          inc(PByte(pWi), (nn - 1)*LineWidthWI);

                          // ... a real pair
                          if q >= 0 then
                          begin
                               z := p + sign(z, p);

                               pWr^ := x + z;
                               inc(PByte(pWr), LineWidthWR);
                               pWr^ := x + z;
                               if z <> 0 then
                                  pWr^ := x - w/z;

                               pWi^ := 0;
                               inc(PByte(pWi), LineWidthWI);
                               pWi^ := 0;

                               // update eigenvectors
                               inc(PByte(pA), LineWidthA);
                               x := pA^;
                               s := abs(x) + abs(z); 
                               p := x/s;
                               q := z/s;
                               r := sqrt(sqr(p) + sqr(q));

                               q := q/r;
                               p := p/r;
                               
                               pAk := pA;     // pA := @a[nn][nn-1]
                               pAj := pA;
                               dec(PByte(pAj), LineWidthA);

                               // row modification
                               for j := nn - 1 to width - 1 do
                               begin
                                    z := pAj^;
                                    pAj^ := q*z + p*pAk^;
                                    pAk^ := q*pAk^ - p*z;
                                    inc(pAk);
                                    inc(pAj);
                               end;

                               // column modification
                               pAj := A;
                               inc(pAj, nn);
                               pAk := pAj;
                               dec(pAk);
                               for i := 0 to nn do
                               begin
                                    z := pAk^;
                                    pAk^ := q*z + p*pAj^;
                                    pAj^ := q*pAj^ - p*z;
                                    inc(PByte(pAk), LineWidthA);
                                    inc(PByte(pAj), LineWidthA);
                               end;

                               // accumulate transformations
                               pEivecj := Eivec;
                               inc(pEivecj, nn - 1);
                               pEiveck := pEivecj;
                               inc(pEiveck);
                               for i := 0 to width - 1 do
                               begin
                                    z := pEivecj^;
                                    pEivecj^ := q*z + p*pEiveck^;
                                    pEiveck^ := q*pEiveck^ - p*z;
                                    inc(PByte(pEivecj), LineWidthEivec);
                                    inc(PByte(pEiveck), LineWidthEivec);
                               end;
                          end
                          else
                          begin
                               // ...a complex pair
                               pWr^ := x + p;
                               inc(PByte(pWr), LineWidthWR);
                               pWr^ := x + p;
                               pWi^ := z;
                               inc(PByte(pWi), LineWidthWI);
                               pWi^ := -z;
                          end;

                          dec(nn, 2);
                     end
                     else
                     begin
                          // no roots found. Continue iteration
                          if its = cMaxEigHessenbergIter then
                             exit;

                          // form exceptional shift
                          if (its = 10) or (its = 20) then
                          begin
                               t := t + x;
                               pAi := A;
                               for i := 0 to nn do
                               begin
                                    pAi^ := pAi^ - x;
                                    inc(pAi);
                                    inc(PByte(pAi), LineWidthA);
                               end;

                               pA := A;
                               inc(pA, nn - 1);
                               inc(PByte(pA), nn*LineWidthA);
                               s := abs(pA^);
                               dec(pA);
                               dec(PByte(pA), LineWidthA);
                               s := s + abs(pA^);
                               x := 0.75*s;
                               y := x;
                               w := -0.4375*sqr(s);
                          end;
                          inc(its);

                          // form shift and the look for 2 consecutive small subdiagonal elements
                          pAm := A;
                          inc(pAm, nn - 2);
                          inc(PByte(pAm), (nn - 2)*LineWidthA);
                          m := nn - 2;
                          while m >= l do
                          begin
                               z := pAm^;
                               r := x - z;
                               s := y - z;

                               pAi := pAm;
                               inc(pAi);
                               pAl := pAm;
                               inc(PByte(pAl), LineWidthA);
                               p := (r*s - w)/pAl^ + pAi^;
                               inc(pAl);
                               q := pAl^ - z - r - s;
                               inc(PByte(pAl), LineWidthA);
                               r := pAl^;
                               // scale to prevent under- or overflow
                               s := abs(p) + abs(q) + abs(r);
                               p := p/s;
                               q := q/s;
                               r := r/s;

                               if m = l then
                                  break;

                               pAi := pAm;
                               dec(pAi);
                               u := abs(pAi^)*(abs(q) + abs(r));
                               dec(PByte(pAi), LineWidthA);
                               dec(PByte(pAl), LineWidthA);
                               v := abs(p)*(abs(pAi^) + abs(z) + abs(pAl^));

                               if u <= cEPS*v then
                                  break;

                               dec(pAm);
                               dec(PByte(pAm), LineWidthA);
                               dec(m);
                          end;

                          pAi := A;
                          inc(pAi, m);
                          inc(PByte(pAi), (m + 2)*LineWidthA);
                          for i := m to nn - 2 do
                          begin
                               pAi^ := 0;
                               if i <> m then
                               begin
                                    dec(pAi);
                                    pAi^ := 0;
                                    inc(pAi);
                               end;

                               inc(pAi);
                               inc(PByte(pAi), LineWidthA);
                          end;

                          // double QR step on rows l to nn and columns m to nn
                          pAk := A;
                          inc(pAk, m - 1);
                          inc(PByte(pAk), m*LineWidthA);
                          for k := m to nn - 1 do
                          begin
                               if k <> m then
                               begin
                                    p := pAk^;
                                    inc(PByte(pAk), LineWidthA);
                                    q := pAk^;
                                    r := 0;
                                    if k + 1 <> nn then
                                    begin
                                         inc(PByte(pAk), LineWidthA);
                                         r := pAk^;
                                         dec(PByte(pAk), LineWidthA);
                                    end;

                                    x := abs(p) + abs(q) + abs(r);

                                    if x <> 0 then
                                    begin
                                         p := p/x;
                                         q := q/x;
                                         r := r/x;
                                    end;

                                    dec(PByte(pAk), LineWidthA);
                               end;

                               s := sign(sqrt(p * p + q * q + r * r), p);

                               if s <> 0 then
                               begin
                                    if k = m then
                                    begin
                                         if l <> m then
                                            pAk^ := -pAk^;
                                    end
                                    else
                                        pAk^ := -s*x;

                                    p := p + s;
                                    x := p/s;
                                    y := q/s;
                                    z := r/s;
                                    q := q/p;
                                    r := r/p;

                                    // Row modification
                                    pAj := A;
                                    inc(PByte(pAj), k*LineWidthA);
                                    inc(pAj, k);
                                    for j := k to width - 1 do
                                    begin
                                         p := pAj^;
                                         inc(PByte(pAj), LineWidthA);
                                         p := p + q*pAj^;

                                         if k + 1 <> nn then
                                         begin
                                              inc(PByte(pAj), LineWidthA);
                                              p := p + r*pAj^;
                                              pAj^ := pAj^ - p*z;
                                              dec(PByte(pAj), LineWidthA);
                                         end;

                                         pAj^ := pAj^ - p*y;
                                         dec(PByte(pAj), LineWidthA);
                                         pAj^ := pAj^ - p*x;
                                         inc(pAj);
                                    end;

                                    // column modification
                                    if nn < k + 3
                                    then
                                        mmin := nn
                                    else
                                        mmin := k + 3;
                                    pAi := A;
                                    inc(pAi, k);
                                    for i := 0 to mmin do
                                    begin
                                         p := x*pAi^;
                                         inc(pAi);
                                         p := p + y*pAi^;
                                         if k + 1 <> nn then
                                         begin
                                              inc(pAi);
                                              p := p + z*pAi^;
                                              pAi^ := pAi^ - p*r;
                                              dec(pAi);
                                         end;
                                         pAi^ := pAi^ - p*q;
                                         dec(pAi);
                                         pAi^ := pAi^ - p;
                                         inc(PByte(pAi), LineWidthA);
                                    end;

                                    // Accumulate transformations
                                    pEiveck := Eivec;
                                    inc(pEiveck, k);
                                    for i := 0 to width - 1 do
                                    begin
                                         p := x*pEiveck^;
                                         inc(pEiveck);
                                         p := p + y*pEiveck^;
                                         if k + 1 <> nn then
                                         begin
                                              inc(pEiveck);
                                              p := p + z*pEiveck^;
                                              pEiveck^ := pEiveck^ - p*r;
                                              dec(pEiveck);
                                         end;
                                         pEiveck^ := pEiveck^ - p*q;
                                         dec(pEiveck);
                                         pEiveck^ := pEiveck^ - p;
                                         inc(PByte(pEiveck), LineWidthEivec);
                                    end;
                               end;

                               inc(pAk);
                               inc(PByte(pAk), LineWidthA);
                          end;
                     end;
                end;
          until l >= nn - 1;
     end;

     // #########################################
     // #### All roots found. Backsubstitute to find vectors of upper triangular form.
     Result := qlOk;
     r := 0;
     s := 0;
     z := 0;
     pWr := Wr;
     pWi := Wi;
     inc(PByte(pWr), (width - 1)*LineWidthWR);
     inc(PByte(pWi), (width - 1)*LineWidthWI);
     for nn := width - 1 downto 0 do
     begin
          p := pWr^;
          q := pWi^;

          na := nn - 1;
          
          if q = 0 then
          begin
               m := nn;
               pAi := A;
               inc(PByte(pAi), nn*LineWidthA);
               inc(pAi, nn);
               pAi^ := 1;

               pWii := pWi;
               dec(PByte(pWii), LineWidthWI);
               pWri := pWr;
               dec(PByte(pWri), LineWidthWR);
               for i := nn - 1 downto 0 do
               begin
                    pAi := A;
                    inc(PByte(pAi), i*LineWidthA);
                    inc(pAi, i);
                    r := 0;
                    w := pAi^ - p;

                    pAj := A;
                    inc(PByte(pAj), i*LineWidthA);
                    inc(pAj, m);

                    pAk := A;
                    inc(PByte(pAk), m*LineWidthA);
                    inc(pAk, nn);
                    for j := m to nn do
                    begin
                         r := r + pAj^*pAk^;
                         inc(pAj);
                         inc(PByte(pAk), LineWidthA);
                    end;

                    if pWii^ < 0 then
                    begin
                         z := w;
                         s := r;
                    end
                    else
                    begin
                         m := i;

                         if pWii^ = 0 then
                         begin
                              t := w;
                              if t = 0 then
                                 t := cEPS*anorm;
                              pA := A;
                              inc(PByte(pA), i*LineWidthA);
                              inc(pA, nn);
                              pA^ := -r/t;
                         end
                         else
                         begin
                              {Solve the linear system:
                              | w   x |  | h[i][nn]   |   | -r |
                              |       |  |            | = |    |
                              | y   z |  | h[i+1][nn] |   | -s |  }
                              pA := A;
                              inc(PByte(pA), i*LineWidthA);
                              inc(pA, i + 1);
                              x := pA^;
                              dec(pA);
                              inc(PByte(pA), LineWidthA);
                              y := pA^;
                              q := sqr(pWri^ - p) + sqr(pWii^);
                              pA := A;
                              inc(PByte(pA), i*LineWidthA);
                              inc(pA, nn);
                              pA^ := (x*s - z*r)/q;
                              t := pA^;
                              inc(PByte(pA), LineWidthA);
                              if abs(x) > abs(z)
                              then
                                  pA^ := (-r - w*t)/x
                              else
                                  pA^ := (-s - y*t)/z;
                         end;

                         // overflow control
                         pA := A;
                         inc(PByte(pA), i*LineWidthA);
                         inc(pA, nn);
                         t := abs(pA^);

                         if cEPS*sqr(t) > 1 then
                         begin
                              for j := i to nn do
                              begin
                                   pA^ := pA^/t;
                                   inc(PByte(pA), LineWidthA);
                              end;
                         end;
                    end;

                    dec(PByte(pWii), LineWidthWI);
                    dec(PByte(pWri), LineWidthWR);
               end;
          end // if q = 0
          else if q < 0 then    // complex vector, only do one case. Last vector chosen imaginary so that eigenvector matrix is triangular
          begin
               m := na;

               pAk := A;
               inc(pAk, nn);
               inc(PByte(pAk), na*LineWidthA);
               pA := A;
               inc(pA, na);
               pAi := pA;
               inc(PByte(pA), (nn)*LineWidthA);
               inc(PByte(pAi), na*LineWidthA);

               pAj := A;
               inc(PByte(pAj), nn*LineWidthA);
               inc(pAj, nn);

               if abs(pA^) > abs(pAk^) then
               begin
                    pAi^ := -q/pA^;
                    pAk^ := -(pAj^ - p)/pA^;
               end
               else
                   Cdiv(0, -pAk^, pAi^ - p, q, pAi^, pAk^);

               pA^ := 0;
               pAj^ := 1;

               pAi := A;
               inc(PByte(pAi), (nn - 2)*LineWidthA);

               pWri := Wr;
               inc(PByte(pWri), (nn - 2)*LineWidthWR);
               pWii := Wi;
               inc(PByte(pWii), (nn - 2)*LineWidthWI);
               for i := nn - 2 downto 0 do
               begin
                    pA := pAi;
                    inc(pA, i);
                    w := pA^ - p;

                    ra := 0;
                    sa := 0;
                    
                    pA := A;
                    inc(PByte(pA), m*LineWidthA);
                    pAk := pA;
                    inc(pA, na);
                    inc(pAk, nn);
                    
                    pAm := pAi;
                    inc(pAm, m);

                    for j := m to nn do
                    begin
                         ra := ra + pAm^*pA^;
                         sa := sa + pAm^*pAk^;

                         inc(pAm);
                         inc(PByte(pA), LineWidthA);
                         inc(PByte(pAk), LineWidthA);
                    end;

                    if pWii^ < 0 then
                    begin
                         z := w;
                         r := ra;
                         s := sa
                    end
                    else
                    begin
                         m := i;

                         pA := pAi;
                         inc(pA, na);
                         pAk := pAi;
                         inc(pAk, nn);

                         if pWii^ = 0
                         then
                             Cdiv(-ra, -sa, w, q, pA^, pAk^)
                         else
                         begin
                              {solve complex linear system:
                              | w+i*q     x | | h[i][na] + i*h[i][en]  |   | -ra+i*sa |
                              |             | |                        | = |          |
                              |   y    z+i*q| | h[i+1][na]+i*h[i+1][en]|   | -r+i*s   |  }
                              pAk := pAi;
                              inc(pAk, i + 1);
                              pAm := pAi;
                              inc(PByte(pAm), LineWidthA);
                              inc(pAm, i);
                              x := pAk^;
                              y := pAm^;

                              vr := sqr(pWri^ - p) + sqr(pWii^) - sqr(q);
                              vi := 2*q*(pWri^ - p);
                              if (vr = 0) and (vi = 0) then
                                 vr := cEPS*anorm*(abs(w) + abs(q) + abs(x) + abs(y) + abs(z));

                              pAk := pAi;
                              inc(pAk, nn);
                              pAm := pAi;
                              inc(pAm, na);
                              CDiv(x*r - z*ra + q*sa, x*s - z*sa - q*ra, vr, vi, pAm^, pAk^);

                              pAl := pAm;
                              inc(PByte(pAl), LineWidthA);
                              pAj := pAk;
                              inc(PByte(pAj), LineWidthA);

                              if abs(x) > abs(z) + abs(q) then
                              begin
                                   pAl^ := (-ra - w*pAm^ + q*pAk^)/x;
                                   pAj^ := (-sa - w*pAk^ - q*pAm^)/x;
                              end
                              else
                                  Cdiv(-r - y*pAm^, -s - y*pAk^, z, q, pAl^, pAj^);
                         end;
                    end;

                    // overflow control
                    pAm := pAi;
                    inc(pAm, na);
                    pAl := pAi;
                    inc(pAl, nn);
                    t := max(Abs(pAm^), Abs(pAl^));

                    if cEps*sqr(t) > 1 then
                    begin
                         for j := i to nn do
                         begin
                              pAm^ := pAm^/t;
                              pAl^ := pAl^/t;
                              inc(PByte(pAm), LineWidthA);
                              inc(PByte(pAl), LineWidthA);
                         end;
                    end;

                    dec(PByte(pWii), LineWidthWI);
                    dec(PByte(pWri), LineWidthWR);
                    dec(PByte(pAi), LineWidthA);
               end;
          end;

          dec(PByte(pWr), LineWidthWR);
          dec(PByte(pWi), LineWidthWI);
     end;


     // multiply by transformation matrix to give vectors of original full matrix
     for j := width - 1 downto 0 do
     begin
          pEiveci := Eivec;
          for i := 0 to width - 1 do
          begin
               z := 0;

               pEivecj := pEiveci;

               pAj := A;
               inc(pAj, j);
               for k := 0 to j do
               begin
                    z := z + pEivecj^*pAj^;
                    inc(PByte(pAj), LineWidthA);
                    inc(pEivecj);
               end;
               
               pEivecj := pEiveci;
               inc(pEivecj, j);
               pEivecj^ := z;

               inc(PByte(pEiveci), LineWidthEivec);
          end;
     end;
end;

procedure MatrixHessenbergInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt);
begin
     MatrixHessenbergPermInPlace(A, LineWidthA, width, nil, 0);
end;

procedure MatrixHessenberg(dest : PDouble; const LineWidthDest : TASMNativeInt; A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt);
begin
     MatrixHessenbergPerm(dest, LineWidthDest, A, LineWidthA, width, nil, 0);
end;

function MatrixUnsymEigVecInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; Eivec : PDouble; const LineWidthEivec : TASMNativeInt) : TEigenvalueConvergence;
var perm : array of integer;
    scale : Array of double;
    pDest : PDouble;
    i: TASMNativeInt;
begin
     setLength(perm, width);
     setLength(scale, width);

     // determine upper hessenberg matrix
     MatrixHessenbergPermInPlace(A, LineWidthA, width, @perm[0], sizeof(integer));

     // initialize to unit matrix -> it's assumed that the eigenvector matrix is already zeroed out!
     pDest := Eivec;
     for i := 0 to width - 1 do
     begin
          pDest^ := 1;
          inc(pDest);
          inc(PByte(pDest), LineWidthEivec);
     end;
     
     MatrixInitEivecHess(A, LineWidthA, width, Eivec, LineWidthEivec, @perm[0], sizeof(integer));

     // calculate eigenvalues and eigenvectors from the hessenberg matrix
     Result := MatrixEigVecHessenbergInPlace(A, LineWidthA, width, Wr, LineWidthWR, Wi, LineWidthWI, Eivec, LineWidthEivec);

     if Result <> qlOk then
        exit;
end;

function MatrixUnsymEigVec(const A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; Eivec : PDouble; const LineWidthEivec : TASMNativeInt) : TEigenvalueConvergence;
var dest : Array of double;
    pA : Pdouble;
    i : TASMNativeInt;
begin
     SetLength(dest, width*width);
     pA := A;

     for i := 0 to width - 1 do
     begin
          Move(pA^, dest[i*width], width*sizeof(double));
          inc(PByte(pA), LineWidthA);
     end;

     Result := MatrixUnsymEigVecInPlace(@dest[0], width*sizeof(double), width, WR, LineWidthWR, WI, LineWidthWI, Eivec, LineWidthEivec);
end;

function MatrixUnsymEigInPlace(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; balance : boolean) : TEigenvalueConvergence;
var scale : Array of double;
begin
     setLength(scale, width);
     if Balance then
        MatrixBalanceInPlace(A, LineWidthA, width, @scale[0], sizeof(double));

     MatrixHessenbergInPlace(A, LineWidthA, width);

     // check eigenvalues on hessenberg matrix
     Result := MatrixEigHessenbergInPlace(A, LineWidthA, width, Wr, LineWidthWR, Wi, LineWidthWI);
end;

function MatrixUnsymEig(const A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt; WR : PDouble;
 const LineWidthWR : TASMNativeInt; WI : PDouble; const LineWidthWI : TASMNativeInt; balance : boolean) : TEigenvalueConvergence;
var dest : Array of double;
    pA : Pdouble;
    i : TASMNativeInt;
begin
     SetLength(dest, width*width);
     pA := A;

     for i := 0 to width - 1 do
     begin
          Move(pA^, dest[i*width], width*sizeof(double));
          inc(PByte(pA), LineWidthA);
     end;

     Result := MatrixUnsymEigInPlace(@dest[0], width*sizeof(double), width, WR, LineWidthWR, WI, LineWidthWI, balance);
end;


// ###########################################
// #### LAPCK Hessenberg
// ###########################################

type
  THessData = record
    mem : Pointer;
    work : PDouble;
    PnlSize : integer;

    reflData : TBlockReflrec; 
    
    // helper pointers
    T : PDouble;       // point to work // (w x h) = (pnlsize + 1 x pnlsize)
    Y : PDouble;       // point to T + tlinewidth*(pnlSize)  (w x h) = (pnlsize x height) 
    tLineWidth : TASMNativeInt;      // pnlsize*sizeof(double)  
    yLineWidth : TASMNativeInt;      // pnlsize*sizeof(double)
    blkMultMem : Pointer; // point to Y + N * NB * sizeof(Double)  
  end;

procedure InitReflectorBlk( var eigData : THessData );
begin
     eigData.reflData.T := eigData.T;
     eigData.reflData.LineWidthT := eigData.tLineWidth;
     eigData.reflData.BlkMultMem := eigData.BlkMultMem;
end;

// single threaded work mem need:
function EigMemSize(const hessData : THessData; width : TASMNativeInt) : TASMNativeInt;
var w4 : TASMNativeInt;
begin
     // for factors of 4.. (better aligned memory)
     w4 := width;
     if w4 and $03 <> 0 then
        w4 := width + 4 - width and $03;

     // + 64 to get aligned ptr for both Y and multiplication (and rank1 updates)
     Result := 64 + Max(2*w4*sizeof(double), hessData.PnlSize*w4*sizeof(double) +  // Y
               hessData.PnlSize*(hessData.PnlSize + 1)*sizeof(double) +  // T
               BlockMultMemSize( Max(QRMultBlockSize, HessMultBlockSize ) ) );  // mult
end;

// unblocked hessenberg decomposition based on DGEHD2
function InternalHessenbergUnblocked( A : PDouble; const LineWidthA : TASMNAtiveInt; iLo : TASMNativeInt; width : TASMNativeInt; tau : PDouble; const eigData : THessData ) : boolean;
var i : TASMNativeInt;
    pA : PDouble;
    pTau : PDouble;
    aii : double;
    pAlpha : PDouble;
    lineRes : boolean;
    pC : PDouble;
begin
     Result := True;
     pTau := Tau;
     for i := iLo to width - 2 do
     begin
          // Generate elemetary reflector H(i) to  annihilate A(i+2:ihi,i)
          pAlpha := GenPtr(A, i, i + 1, LineWidthA);
          pA := GenPtr(A, i, min(i + 2, width - 1), LineWidthA);

          lineRes := GenElemHousholderRefl(pA, LineWidthA, width - i - 1, pAlpha^, pTau);

          Result := lineRes and Result;

          // Apply H(i) to A(1:ihi,i+1:ihi) from the right
          aii := pAlpha^;
          pAlpha^ := 1;

          pC := GenPtr(A, i + 1, 0, LineWidthA);
          ApplyElemHousholderReflRight(pAlpha, LineWidthA, pC, LineWidthA, width - i - 1, width, pTau, eigData.work);

          // Apply H(i) to A(i+1:ihi,i+1:n) from the left
          pC := GenPtr(A, i + 1, i + 1, LineWidthA);
          ApplyElemHousholderReflLeft (pAlpha, LineWidthA, pC, LineWidthA, width - i - 1, width - i - 1, pTau, eigData.work);
          pAlpha^ := aii;

          inc(pTau);
     end;
end;


//function WriteMtx(data : PDouble; LineWidth : TASMNativeInt; width : integer; height : integer; prec : integer = 4) : string; 
//var x, y : integer;
//    pData : PConstDoubleArr;
//begin
//     Result := '';
//
//     for y := 0 to height - 1 do
//     begin
//          pData := PConstDoubleArr( data );
//          for x := 0 to width - 1 do
//              Result := Result + Format('%.*f ', [prec, pData^[x]]);
//
//          inc(PByte(data), LineWidth);
//          Result := Result + #13#10;
//     end;
//end;



//  DLAHR2 reduces the first NB columns of A real general n-BY-(n-k+1)
//  matrix A so that elements below the k-th subdiagonal are zero. The
//  reduction is performed by an orthogonal similarity transformation
//  Q' * A * Q. The routine returns the matrices V and T which determine
//  Q as a block reflector I - V*T*V', and also the matrix Y = A * V * T.
//procedure dlahr2( A : PDouble; const LineWidthA : TASMNativeInt; T : PDouble; const LineWidthT : TASMNativeInt; Y : PDouble; const LineWidthY : TASMNativeInt; Tau : PDouble; N, K, NB : integer; const eigData : THessData);
function InternalHessenbergBlocked( A : PDouble; const LineWidthA : TASMNativeInt; Tau : PDouble; N, K, NB : integer; const eigData : THessData) : boolean;
var i: Integer;
    pA : PDouble;
    pV : PDouble;
    pY : PDouble;
    pT : PDouble;
    ei : double;
    pb1 : PDouble;
    pb2 : PDouble;
    pV1 : PDouble;
    pV2 : PDouble;
    pW : PDouble;
    pALpha : PDouble;
    pA1 : PDouble;
    nki : Integer;
//    lineRes : boolean;
    //s : string;
begin
     // quick return
     Result := True;
     
     if n <= 1 then
        exit;

     //s := WriteMtx( A, LineWidthA, 7, 7, 3 );
     ei := 0;
     pAlpha := nil;

     for i := 0 to NB - 1 do
     begin
          // N-K-I+1 -> height
          nki := N - k - i - 1;

          if i > 0 then
          begin
               // Let V = (V1)   b = (b1)  (first I - 1 rows)
               //         (V2)       (b2)
               // where V1 is unit lower triangular
               
               // Update A(K+1:N,I)
               // Update I-th column of A - Y * V'
               pA := GenPtr(A, i, K + 1, LineWidthA);    // A(k + 1, i )
               pV := GenPtr(A, 0, K + i, LineWidthA );   // A(k + i - 1, 1);
               pY := GenPtr(eigData.Y, 0, K + 1, eigData.yLineWidth );   // y(k + 1, 1)
               MatrixMtxVecMult( pA, LineWidthA, pY, pV, eigData.yLineWidth, sizeof(double), i, N-k-1, -1, 1 );

               //s := WriteMtx(A, LineWidthA, 2*nb, 5);
               
               // apply I - V*T'*V' to this column (call it b) from the left using the last column of T as workspace

               // w = V1'*b1
               pV1 := GenPtr(A, 0, k + 1, LineWidthA);
               pV2 := GenPtr(A, 0, k + i + 1, LineWidthA );

               pb1 := GenPtr(A, i, k + 1, LineWidthA );
               pb2 := GenPtr(A, i, k + i + 1, LineWidthA );

               pW := GenPtr(eigData.T, NB - 1, 0, eigData.tLineWidth );

               MatrixCopy( pW, eigData.tLineWidth, pb1, LineWidthA, 1, i );
               // s := WriteMtx(pW, LineWidthT, nb, 5);
               // orig dtrmv lower transpose unit
               MtxMultLowTranspUnitVec( pV1, LineWidthA, pW, eigData.tLineWidth, i );

               //s := WriteMtx(pW, LineWidthT, nb, 5);
               
               // w := w + V2'*b2
               MatrixMtxVecMultT(pW, eigData.tLineWidth, pV2, pB2, LineWidthA, LineWidthA, i, nki, 1, 1);
               //s := WriteMtx(pW, LineWidthT, nb, 5);

               // w := T'*w
               MtxMultUpTranspNoUnitVec( eigData.T, eigData.tLineWidth, pW, eigData.tLineWidth, i );
               //s := WriteMtx(pW, LineWidthT, nb, 5);
               
               // b2 = b2 - V2*w
               //MatrixMultEx(pb2, LineWidthA, pV2, pW, i, N - k - i, 1, i, LineWidthA, LineWidthT, BlockMatrixCacheSize, doSub, eigData.blkMultMem );
               MatrixMtxVecMult(pB2, LineWidthA, pV2, pW, LineWidthA, eigData.tLineWidth, i, nki, -1, 1);
               //s := WriteMtx(A, LineWidthA, 2*nb, 5);
               
               // b1 = b1 - V1*w
               MtxMultLowNoTranspUnitVec( pV1, LineWidthA, pW, eigData.tLineWidth, i );
               MatrixSub( pb1, LineWidthA, pb1, pW, 1, i, LineWidthA, eigData.tLineWidth );

               //s := WriteMtx(A, LineWidthA, 2*nb, 5);

               pAlpha^ := ei;
          end;

          // ###########################################
          // #### Elementary reflector H(i) to annihilate A(k + i + 1:N, i)
          pAlpha := GenPtr( A, i, K + i + 1, LineWidthA );
          pA := GenPtr( A, i, Min( K + i + 2, N - 1), LineWidthA );
          Result := GenElemHousholderRefl( pA, LineWidthA, nki, pAlpha^, tau ) and Result;
          ei := pAlpha^;
          pAlpha^ := 1;

          // compute y(k + 1:N, i )
          pA1 := GenPtr( A, i + 1, k + 1, LineWidthA );
          pY := GenPtr( eigData.Y, i, k + 1, eigData.yLineWidth );
          pT := GenPtr( eigData.T, i, 0, eigData.tLineWidth );

          MatrixMtxVecMult( pY, eigData.yLineWidth, pA1, pAlpha, LineWidthA, LineWidthA, nki, N - k - 1, 1, 0 );

          //s := WriteMtx(eigData.Y, eigData.yLineWidth, nb, 5);
          
          if i > 0 then
          begin
               MatrixMtxVecMultT( pT, eigData.tLineWidth, GenPtr( A, 0, k + i + 1, LineWidthA), pAlpha, LineWidthA, LineWidthA, i, nki, 1, 0 );
               MatrixMtxVecMult( pY, eigData.yLineWidth, GenPtr( eigData.Y, 0, k + 1, eigData.yLineWidth ), pT, eigData.yLineWidth, eigData.tLineWidth, i, N - k - 1, -1, 1 );
          end;
          MatrixScaleAndAdd( pY, eigData.yLineWidth, 1, N - k - 1, 0, tau^ );

          //s := WriteMtx(eigData.Y, eigData.yLineWidth, nb, 5);
          
          // compute T(1:i, i)
          if i > 0 then
          begin
               MatrixScaleAndAdd( pT, eigData.tLineWidth, 1, i, 0, -tau^ );
               MtxMultUpNoTranspNoUnitVec( eigData.T, eigData.tLineWidth, pT, eigData.tLineWidth, i );
          end;
          pT := GenPtr(eigData.T, i, i, eigData.tLineWidth );
          pT^ := tau^;
          //s := WriteMtx(T, LineWidthT, nb, nb);

          inc(tau);
     end;

     //s := WriteMtx(eigData.Y, eigData.yLineWidth, nb, 5);

     pA := GenPtr( A, NB - 1, k + NB, LineWidthA );
     pA^ := ei;

     // compute Y(1:K, 1:NB)
     MatrixCopy( eigData.Y, eigData.yLineWidth, GenPtr(A, 1, 0, LineWidthA ), LineWidthA, NB, k + 1);
     //s := WriteMtx(eigData.Y, eigData.yLineWidth, nb, 5);
     MtxMultTria2LowerUnit( GenPtr(A, 0, k + 1, LineWidthA ), LineWidthA, eigData.Y, eigData.yLineWidth, NB, NB, NB, k + 1 );
     //s := WriteMtx(eigData.Y, eigData.yLineWidth, nb, 5);
//        IF( n.GT.k+nb )
//      $   CALL dgemm( 'NO TRANSPOSE', 'NO TRANSPOSE', k,
//      $               nb, n-k-nb, one,
//      $               a( 1, 2+nb ), lda, a( k+1+nb, 1 ), lda, one, y,
//      $               ldy )
     if n >= k + nb then
        eigData.reflData.MatrixMultEx( eigData.Y, eigData.yLineWidth,
                                       GenPtr(A, 1 + NB, 0, LineWidthA),
                                       GenPtr(A, 0, K + 1 + NB, LineWidthA),
                                       n - k - nb - 1, k + 1, nb, n - k - nb - 1,
                                       LineWidthA, LineWidthA,
                                       HessMultBlockSize, doAdd, eigData.blkMultMem );
                                       
     //s := WriteMtx(eigData.Y, eigData.yLineWidth, nb, 5);
     MtxMultTria2UpperNoUnit( eigData.T, eigData.tLineWidth, eigData.Y, eigData.yLineWidth, NB, NB, NB, K + 1 );
     //s := WriteMtx(T, LineWidthT, nb, nb);
end;


// original DGEHRD
function InternalMatrixHessenberg(A : PDouble; const LineWidthA : TASMNAtiveInt; width : TASMNativeInt; tau : PDouble; const eigData : THessData ) : boolean;
var i : integer;
    pA : PDouble;
    pTau : PDouble;
    ib : integer;
    ei : double;
    pAib : PDouble;
    pA1, pA2 : PDouble;
    j : Integer;
    //s, s1, s2 : string;
begin
     MtxMemInit( tau, width*sizeof(double), 0 );

     Result := True;
     // ###########################################
     // #### blocked code
     i := 0;
     pTau := tau;
     while i + eigData.PnlSize + 2 < width do
     begin
          ib := eigData.PnlSize;
          
          // reduce colums i:i+pnlsize -1  to hessenberg form returning the matrices V and T of the block reflector H  I _ V*T*V' 
          // which performs the reduction and also the matrix Y = A*V*T
          pA := GenPtr(A, i, 0, LineWidthA);
          //dlahr2( pA, LineWidthA, eigData.T, eigData.tLineWidth, eigData.Y, eigData.yLineWidth, pTau, width, i, ib, eigData );
          Result := InternalHessenbergBlocked( pA, LineWidthA, pTau, width, i, ib, eigData ) and Result;

         // s := WriteMtx(eigData.T, eigData.tLineWidth, ib, ib);
//          s2 := WriteMtx(eigData.Y, eigData.yLineWidth, ib, width - ib);
//          s1 := WriteMtx(A, LineWidthA, 5, 5);
          

          //  Apply the block reflector H to A(1:ihi,i+ib:ihi) from the
          // right, computing  A := A - Y * V'. V(i+ib,ib-1) must be set to 1
          pAib := GenPtr( A, i + ib - 1, i + ib, LineWidthA );
          ei := pAib^;
          pAib^ := 1;
          pA1 := GenPtr( A, i, i + ib, LineWidthA );
          pA2 := GenPtr( A, i + ib, 0, LineWidthA );

          //  EI = A( I+IB, I+IB-1 )
          //  A( I+IB, I+IB-1 ) = ONE
          //  CALL DGEMM( 'No transpose', 'Transpose',
     //$                  IHI, IHI-I-IB+1,
     //$                  IB, -ONE, WORK, LDWORK, A( I+IB, I ), LDA, ONE,
     //$                  A( 1, I+IB ), LDA )
          eigData.reflData.MatrixMultT2(pA2, LineWidthA, eigData.Y, pA1, ib, width, ib, width - i - ib,
                                        eigData.yLineWidth, LineWidthA, HessMultBlockSize, doSub, eigData.blkMultMem );
          pAib^ := ei;

          //s1 := WriteMtx(A, LineWidthA, 5, 5);
//          s2 := WriteMtx(pA2, LineWidthA, 5, 5);

          // apply the block reflector H to A from the right
          // dtrmm right lower transpose unit
          pA := GenPtr( A, i, i + 1, LineWidthA );
          //CALL DTRMM( 'Right', 'Lower', 'Transpose',
//     $                  'Unit', I, IB-1,
//     $                  ONE, A( I+1, I ), LDA, WORK, LDWORK )
          MtxMultLowTria2T2Store1(eigData.Y, eigData.yLineWidth,
                                  pA, LineWidthA, ib - 1, i + 1,
                                  ib - 1, ib - 1 );

          // DO 30 j = 0, ib-2
                //CALL daxpy( i, -one, work( ldwork*j+1 ), 1,
//      $                     a( 1, i+j+1 ), 1 )
//    30       CONTINUE
          for j := 0 to ib - 2 do
              MatrixSubVec( GenPtr( A, i + j + 1, 0, LineWidthA ), LineWidthA, GenPtr(eigData.Y, j, 0, eigData.yLineWidth ), eigData.yLineWidth,
                             1, i + 1, False );

          //s1 := WriteMtx(A, LineWidthA, 5, 5);
          // apply the block reflector H to A from the left
           //CALL DLARFB( 'Left', 'Transpose', 'Forward',
//     $                   'Columnwise',
//     $                   IHI-I, N-I-IB+1, IB, A( I+1, I ), LDA, T, LDT,
//     $                   A( I+1, I+IB ), LDA, WORK, LDWORK )
          ApplyBlockReflectorLTFC(pA, LineWidthA, eigData.reflData, width - i - ib, width - i - 1, ib, false);   // original dlarfb call is transposed but dlarfb reroutes to non transposed?!?

          //s1 := WriteMtx(A, LineWidthA, 5, 5);
//          s2 := WriteMtx(pA, LineWidthA, 5, 5);          
     
          inc(pTau, eigData.PnlSize);
          inc(i, eigData.PnlSize);
     end;

     // ###########################################
     // #### last non blocked part
     Result := InternalHessenbergUnblocked( A, LineWidthA, i, width, pTau, eigData) and Result;
end;

procedure MatrixQFromHessenbergDecomp(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt;
 tau : PDouble; progress : TLinEquProgress = nil); overload;
begin  
     MatrixQFromHessenbergDecomp(A, LineWidthA, width, tau, QRBlockSize, nil, progress); 
end;

procedure MatrixQFromHessenbergDecomp(A : PDouble; const LineWidthA : TASMNativeInt; width : TASMNativeInt;
 tau : PDouble; BlockSize : TASMNativeInt; work : PDouble; progress : TLinEquProgress = nil);
var i, j : TASMNativeInt;
    pAj : PConstDoubleArr;
begin
     // shift the vectors which define the elementary feflectors one column to the right
     // 
     pAj := PConstDoubleArr(A);
     pAj^[0] := 1;
     for i := 1 to width - 1 do
         pAj^[i] := 0;

     // shift columns and zero out
     for j := 1 to width - 1 do
     begin
          pAj := GenPtrArr(A, 0, j, LineWidthA);
          for i := j downto 1 do
              pAj^[i] := pAj^[i - 1];
          for i := j + 1 to width - 1 do
              pAj^[i] := 0;
              
          pAj^[0] := 0;
     end;

     MatrixQFromQRDecomp(GenPtr(A, 1, 1, LineWidthA), LineWidthA, width - 1, width - 1, tau, BlockSize, work, progress);
end;

function MatrixHessenberg2InPlace(A : PDouble; const LineWidthA : TASMNAtiveInt; width : TASMNativeInt; tau : PDouble; hessBlockSize : integer) : TEigenvalueConvergence; 
var hessWork : THessData;
begin
     FillChar(hessWork, sizeof(hessWork), 0 );
     
     hesswork.PnlSize := hessBlockSize;
     hessWork.work := MtxAllocAlign( EigMemSize(hesswork, width), hessWork.mem ); 
     hessWork.T := hessWork.work;
     hessWork.tLineWidth := sizeof(double)*hesswork.PnlSize;
     // Y needs to point directly "under" T to work with the block reflectors
     hessWork.Y := GenPtr(hessWork.work, 0, hesswork.PnlSize, hessWork.tLineWidth);
     hessWork.yLineWidth := hessWork.tLineWidth;

     // align ptr just around "under" Y
     hessWork.blkMultMem := AlignPtr32( GenPtr( hessWork.work, 0, hesswork.PnlSize + width, hessWork.tLineWidth ) );
     
     hessWork.reflData.MatrixMultT1 := {$IFDEF FPC}@{$ENDIF}MatrixMultT1Ex;
     hessWork.reflData.MatrixMultT2 := {$IFDEF FPC}@{$ENDIF}MatrixMultT2Ex;
     hessWork.reflData.MatrixMultEx := {$IFDEF FPC}@{$ENDIF}MatrixMultEx;

     Result := qlOk;     
     InitReflectorBlk(hessWork);
     try
        if not InternalMatrixHessenberg( A, LineWidthA, width, tau, hessWork ) then
           Result := qlMatrixError;
     finally
            FreeMem(hessWork.mem);
     end;
end;

function ThrMtxHessenberg2InPlace(A : PDouble; const LineWidthA : TASMNAtiveInt; width : TASMNativeInt; tau : PDouble; hessBlockSize : integer) : TEigenvalueConvergence; 
var hessWork : THessData;
begin
     // around here is a good crossover point where multithreaded code starts to be faster
     if width < 150 then
     begin
          Result := MatrixHessenberg2InPlace(A, LineWidthA, width, tau, hessBlockSize);
          exit;
     end;
     FillChar(hessWork, sizeof(hessWork), 0 );
     
     hesswork.PnlSize := hessBlockSize;
     hessWork.work := MtxAllocAlign( EigMemSize(hesswork, width) + (numCPUCores - 1)*BlockMultMemSize( Max(QRMultBlockSize, HessMultBlockSize) ), hessWork.mem ); 
     hessWork.T := hessWork.work;
     hessWork.tLineWidth := sizeof(double)*hesswork.PnlSize;
     // Y needs to point directly "under" T to work with the block reflectors
     hessWork.Y := GenPtr(hessWork.work, 0, hesswork.PnlSize, hessWork.tLineWidth);
     hessWork.yLineWidth := hessWork.tLineWidth;

     // align ptr just around "under" Y
     hessWork.blkMultMem := AlignPtr32( GenPtr( hessWork.work, 0, hesswork.PnlSize + width, hessWork.tLineWidth ) );
     
     hessWork.reflData.MatrixMultT1 := {$IFDEF FPC}@{$ENDIF}ThrMatrixMultT1Ex;
     hessWork.reflData.MatrixMultT2 := {$IFDEF FPC}@{$ENDIF}ThrMatrixMultT2Ex;
     hessWork.reflData.MatrixMultEx := {$IFDEF FPC}@{$ENDIF}ThrMatrixMultEx;

     Result := qlOk;     
     InitReflectorBlk(hessWork);
     try
        if not InternalMatrixHessenberg( A, LineWidthA, width, tau, hessWork ) then
           Result := qlMatrixError;
     finally
            FreeMem(hessWork.mem);
     end;
end;

end.
