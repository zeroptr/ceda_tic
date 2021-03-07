
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid filter common                            }
{                                                                   }
{       Copyright (c) 1998-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxGrFCmn;

interface

{$I dxTLVer.inc}

type
  TdxDBGridOperatorType = (gotEqual, gotNotEqual,
    gotGreater, gotGreaterEqual, gotLess,  gotLessEqual,
    gotBlank, gotNonBlank);
  TdxDBGridOperatorTypes = set of TdxDBGridOperatorType;
  
resourcestring
  dxSFilterOperatorEqual = 'equals';
  dxSFilterOperatorNotEqual = 'does not equal';
  dxSFilterOperatorGreater = 'is greater than';
  dxSFilterOperatorGreaterEqual = 'is greater than or equal to';
  dxSFilterOperatorLess = 'is less than';
  dxSFilterOperatorLessEqual = 'is less than or equal to';
  dxSFilterOperatorBlanks = 'blanks';
  dxSFilterOperatorNonBlanks = 'non blanks';
  dxSFilterInvalidValue = 'Invalid value';
  dxSFilterStatusCloseButtonHint = 'Clear Filter';
  dxSFilterBoxAllCaption = '(All)';
  dxSFilterBoxCustomCaption = '(Custom...)';
  dxSFilterBoxBlanksCaption = '(Blanks)';
  dxSFilterBoxNonBlanksCaption = '(NonBlanks)';

implementation

end.
