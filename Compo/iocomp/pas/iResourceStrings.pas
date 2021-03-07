{*******************************************************}
{                                                       }
{       Resource Strings                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iResourceStrings;{$endif}
{$ifdef iCLX}unit QiResourceStrings;{$endif}

interface

resourcestring
               SVersionString     = 'Version 4.0.0';
  {$IFDEF EVAL}SServicePackString = 'Service Pack 0 (Evaluation)';
  {$ELSE}      SServicePackString = 'Service Pack 0';{$ENDIF}
               SCopyrightString   = 'Copyright © 1998-2008 Iocomp Software Inc.';

  SLicenseAgreement1   = 'PLEASE READ THE FOLLOWING LICENSE AGREEMENT. IT WILL BE NECESSARY FOR YOU TO AGREE TO BE BOUND BY THE TERMS OF THIS AGREEMENT BEFORE BEING PERMITTED TO CONTINUE TO INSTALL THE PRODUCT. THE PROCEDURE FOR ACCEPTING OR ';
  SLicenseAgreement2   = 'REJECTING THE LICENSE AGREEMENT IS SET OUT AFTER THE LICENSE AGREEMENT.';
  SLicenseAgreement3   = #13 + #10 + #13 + #10;
  SLicenseAgreement4   = 'IF YOU DO NOT ACCEPT THE TERMS OF THE LICENSE AGREEMENT FOR ANY SOFTWARE PRODUCT FOR WHICH YOU HAVE RECEIVED THE CD-KEY(S) WITH THIS CD-ROM OR OBTAINED THE CD-KEY(S) THROUGH AN AUTHORIZED SOURCE, THE INSTALLATION ';
  SLicenseAgreement5   = 'PROCESS WILL BE TERMINATED. YOU SHOULD PROMPTLY RETURN THE UNUSED SOFTWARE PRODUCT FOR A REFUND OF THE AMOUNT PAID FOR THE PARTICULAR PRODUCT WITHIN THIRTY (30) DAYS OF THE DATE OF PURCHASE';
  SLicenseAgreement6   = #13 + #10;
  SLicenseAgreement7   = 'LICENSE AGREEMENT FOR IOCOMP SOFTWARE:';
  SLicenseAgreement8   = 'VERY IMPORTANT-CAREFULLY READ : This Iocomp Software License Agreement (hereinafter "LICENSE") is a legal agreement between you (either an individual or a single entity) and Iocomp Software Systems, Inc. ("Iocomp"),';
  SLicenseAgreement9   = ' for the SOFTWARE or products identified on the disk or CD-ROM labels enclosed with this package and for which the CD-Keys(s) are either provided on the back of the enclosed CD case or obtained through Iocomp or an';
  SLicenseAgreement10  = ' authorized distributor, which includes computer software and associated media and printed materials, and may include "on-line" or electronic documentation ("SOFTWARE"). By installing using the correct CD-Keys,';
  SLicenseAgreement11  = ' copying or otherwise using the SOFTWARE, you agree to be bound by the terms of this LICENSE. If you do not agree to the terms of this LICENSE, promptly return the unused SOFTWARE to the place from which you obtained';
  SLicenseAgreement12  = ' it for a full refund.';
  SLicenseAgreement13  = #13 + #10;
  SLicenseAgreement14  = 'SOFTWARE LICENSE';
  SLicenseAgreement15  = 'The SOFTWARE is protected by copyright laws and international copyright treaties, as well as other intellectual property laws and treaties. The SOFTWARE is licensed, not sold.';
  SLicenseAgreement16  = #13 + #10;
  SLicenseAgreement17  = 'I. LICENSE GRANT. This LICENSE grants you the following rights:';
  SLicenseAgreement18  = 'A. You may use one copy of the Iocomp SOFTWARE identified above on a single computer. The SOFTWARE is in "use" on a computer when it is loaded into temporary memory (i.e. RAM) or installed into permanent memory';
  SLicenseAgreement19  = ' (e.g. hard disk, CD-ROM, or other storage device) of that computer. However, installation on a network server for the sole purpose of internal distribution to one or more other computer(s) shall not constitute';
  SLicenseAgreement20  = ' "use" for which a separate license is required, provided you have a separate license for each computer to which the SOFTWARE is distributed.';
  SLicenseAgreement21  = 'B. Solely with respect to electronic documents included with the SOFTWARE, you may make a copy (either in hardcopy or electronic form), provided that the number of copies made shall not exceed the number of licenses';
  SLicenseAgreement22  = ' you own for that SOFTWARE, and further provided that such copies shall be used only for internal purposes and are not republished or distributed to any third party.';
  SLicenseAgreement23  = 'C. You may use the trial versions and product tours, as described on the CD-ROM, of the software products included on this CD-ROM for the limited purposes of demonstrations, trials and design time evaluations and';
  SLicenseAgreement24  = ' running a product tour.';
  SLicenseAgreement25  = #13 + #10;
  SLicenseAgreement26  = 'II. TITLE; COPYRIGHT. All title and copyrights in and to the SOFTWARE (including but not limited to any images, photographs, animation, video, audio, music, text and "applets" incorporated into the SOFTWARE), the';
  SLicenseAgreement27  = ' accompanying printed materials, and any copies of the SOFTWARE are owned by IOCOMP or its suppliers. The SOFTWARE is protected by copyright laws and international treaty provisions. Therefore, you must treat the';
  SLicenseAgreement28  = ' SOFTWARE like any other copyrighted material, except that you may either (A) make one copy of the SOFTWARE solely for backup or archival purposes or (B) install the SOFTWARE on a single computer provided you keep';
  SLicenseAgreement29  = ' the original solely for backup or archival purposes. You may not copy the printed materials accompanying the SOFTWARE.';
  SLicenseAgreement30  = #13 + #10;
  SLicenseAgreement31  = 'III. ADDITIONAL RIGHTS AND LIMITATIONS.';
  SLicenseAgreement32  = 'A. Reverse Engineering, Decompilation, and Disassembly. You may not reverse engineer, decompile, or disassemble the SOFTWARE.';
  SLicenseAgreement33  = 'B. No Separation of Components. The SOFTWARE is licensed as a single product and the software programs comprising the SOFTWARE may not be separated for use by more than one user at a time.';
  SLicenseAgreement34  = 'C. Rental. You may not rent or lease the SOFTWARE.';
  SLicenseAgreement35  = 'D. Software Transfer. You may NOT transfer any of your rights under this LICENSE.';
  SLicenseAgreement36  = 'E. Termination. Without prejudice to any other rights, Iocomp may terminate this LICENSE if you fail to comply with the terms and conditions of this LICENSE. In such event, you must destroy all copies of the SOFTWARE.';
  SLicenseAgreement37  = 'F. The Source Code to portions of the Software is provided by Iocomp in an installation package to any Licensee that is authorized, provided that Licensee has purchased the Std, Pro, Plot or Ultra Pack (ActiveX/VCL) version license.';
  SLicenseAgreement38  = 'Source Code is only provided for the (.Net) version when a (.Net) Site/OEM license is purchased and a NDA (Non-Disclosure-Agreement) is signed and returned to Iocomp by the Licensee.';
  SLicenseAgreement39  = #13 + #10;
  SLicenseAgreement40  = 'If Licensee is Authorized to receive the product Source Code, Iocomp grants Licensee the non-exclusive license to view and modify the Source Code for the sole purposes of education and troubleshooting.';
  SLicenseAgreement41  = 'If Licensee troubleshoots the Source Code, Licensee may compile the corrected source code and use and distribute the resulting object code solely as a replacement for the corresponding Redistributable Files the Source Code compiles into.';
  SLicenseAgreement42  = #13 + #10;
  SLicenseAgreement43  = 'The foregoing license is subject to the following conditions: (i) Iocomp shall retain all rights, title and interest in and to all corrections, modifications and derivative works of the Source Code created by Licensee,';
  SLicenseAgreement44  = ' including all copyrights subsisting therein, to the extent such corrections, modifications or derivative works contain copyrightable code or expression derived from the Source Code;';
  SLicenseAgreement45  = ' (ii) Licensee may not distribute or disclose the Source Code, or any portions or modifications or derivative works thereof, to any third party, in source code form;';
  SLicenseAgreement46  = ' (iii) Licensee acknowledges that the Source Code contains valuable and proprietary trade secrets of Iocomp and agrees to expend every effort to insure its confidentiality; (iv) Under no circumstances may the Source Code be used,';
  SLicenseAgreement47  = ' in whole or in part, as the basis for creating a product that provides the same, or substantially the same, functionality as any Iocomp product;';
  SLicenseAgreement48  = ' (v) If Licensee distributes a compiled version of the corrected Source Code or portions thereof, Licensee must distribute it in accordance with the conditions listed in section IV ("REDISTRIBUTABLE COMPONENTS") regarding the distribution';
  SLicenseAgreement49  = ' of Redistributable Files.';
  SLicenseAgreement50  = #13 + #10;
  SLicenseAgreement51  = 'IV. REDISTRIBUTABLE COMPONENTS.';
  SLicenseAgreement52  = 'A. Sample Code. In addition to the license granted in Section 1, Iocomp grants you the right to use and modify the source code versions of those portions of the SOFTWARE which are identified in the documentation as the';
  SLicenseAgreement53  = ' Sample Code and located in the \EXAMPLES(xx) subdirectory(s) of the SOFTWARE, either on disk, CD-ROM or electronic format (collectively "SAMPLE CODE") provided you comply with section 4.c. You may not distribute the';
  SLicenseAgreement54  = ' EXAMPLE CODE, or any modified version of the EXAMPLE CODE, in source code form.';
  SLicenseAgreement55  = 'B. Redistributable Code. In addition to the license granted in Section 1, Iocomp grants you a nonexclusive, royalty-free right to reproduce and distribute the object code version of those portions of the SOFTWARE';
  SLicenseAgreement56  = 'designated in the SOFTWARE as (i) those portions of the SOFTWARE which are identified in the documentation as the VBX ("VBX") and/or OCX ("OCX") Controls; (ii) those portions of the SOFTWARE which are identified in the';
  SLicenseAgreement57  = ' documentation as REDISTRIBUTABLE DLLs ("DLLs"); and (iii) SAMPLE CODE (collectively, "REDISTRIBUTABLES"), provided you comply with Section 4.c.';
  SLicenseAgreement58  = 'C. Redistribution Requirements. If you redistribute the REDISTRIBUTABLES, you agree to (i) distribute the REDISTRIBUTABLES in object code form only in conjunction with and as part of your software application product';
  SLicenseAgreement59  = ' which adds significant and primary functionality and which is designed, developed, and tested to operate in the Microsoft Windows and/or Windows NT environments; (ii) not use Iocomp''s name, logo or trademarks to market';
  SLicenseAgreement60  = ' your software application product; (iii) include a valid copyright notice on your SOFTWARE; (iv) indemnify, hold harmless, and defend Iocomp from and against any claims or lawsuits, including attorney''s fees, that arise';
  SLicenseAgreement61  = ' or result from the use and distribution of your software application product; and (v) not permit further distribution of the REDISTRIBUTABLES by your end user.';
  SLicenseAgreement62  = 'D. OPC Runtime License. If you utilize the OPC (OLE for Process Control) features of the SOFTWARE, a DISTRIBUTION LICENSE must be obtained to distribute the REDISTRIBUTABLES. Installation of SOFTWARE on additional computers which utilize the';
  SLicenseAgreement63  = ' OPC features of the SOFTWARE must have an OPC RUNTIME LICENSE.';
  SLicenseAgreement64  = 'The OPC FEATURES included with your SOFTWARE LICENSE are for testing purposes only if you do not purchase an OPC Runtime License. Additional OPC RUNTIME LICENSES can be purchased from Iocomp Software or from an Iocomp Authorized Reseller.';
  SLicenseAgreement65  = 'The OPC OEM Deployment License allows for unlimited distribution of a single application product using the OPC features of the SOFTWARE.';
  SLicenseAgreement66  = 'E. OEM/1000 Development License.  If you allow development with the SOFTWARE COMPONENTS from within your software application product, you will need to obtain an OEM/1000 Development License.';
  SLicenseAgreement67  = 'The OEM/1000 Development License allows you to distribute up to 1000 copies of your software application product that enable development with our SOFTWARE COMPONENTS.  Development must be contained within your software application product.';
  SLicenseAgreement68  = 'Development is defined as the ability of your software application product to do ALL three of the following: i. Add and/or Remove our SOFTWARE COMPONENTS ii. modify our SOFTWARE COMPONENTS properties, methods, and/or events iii. Persist or';
  SLicenseAgreement69  = ' Save/Load the properties of the SOFTWARE COMPONENTS.';
  SLicenseAgreement70  = #13 + #10;
  SLicenseAgreement71  = 'V. U.S. GOVERNMENT RESTRICTED RIGHTS. The SOFTWARE and documentation are provided with RESTRICTED RIGHTS. Use, duplication, or disclosure by the Government is subject to restrictions as set forth in subparagraph';
  SLicenseAgreement72  = ' (c) (1) (ii) of the Rights in Technical Data and Computer Software clause at DFARS 252.227-7013 or subparagraphs (c) (1) and (2) of the Commercial Computer Software - Restricted Rights at 48 CFR 52.227-19, as applicable.';
  SLicenseAgreement73  = ' Manufacturer is Iocomp Software Systems, Inc., 6635 Hidden Beach Circle, Orlando, FL 32819.';
  SLicenseAgreement74  = #13 + #10;
  SLicenseAgreement75  = 'VI. EXPORT AND USE.  You are acknowledging that you are responsible for complying with all trade regulations and laws both foreign and domestic and agreeing that you will not use or otherwise export or re-export, directly or indirectly,';
  SLicenseAgreement76  = 'this SOFTWARE or underlying information or technology except as authorized by United States law and the laws of the jurisdiction in which the SOFTWARE was obtained.';
  SLicenseAgreement77  = 'In particular, but without limitation, the SOFTWARE may not be exported or re-exported, directly or indirectly, (i) into (or to a national or resident of) any U.S. embargoed country, including without limitation Afghanistan, Cuba, Iran,';
  SLicenseAgreement78  = ' Iraq, Libya, North Korea, Sudan or Syria or';
  SLicenseAgreement79  = ' (ii) to anyone on the U.S. Treasury Department list of Specially Designated Nationals or the U.S. Department of Commerce Table of Denial Orders or (iii) for any end-use that is prohibited by United States law and the laws of the';
  SLicenseAgreement80  = ' jurisdiction in which the Technology was obtained.';
  SLicenseAgreement81  = 'By downloading and/or using the SOFTWARE, you represent and warrant that you are not located in, under control of, or a national or resident of any such country or on any such list and that no U.S. federal agency has suspended, revoked,';
  SLicenseAgreement82  = ' or denied your export privileges.';
  SLicenseAgreement83  = #13 + #10;
  SLicenseAgreement84  = 'LIMITED WARRANTY';
  SLicenseAgreement85  = 'LIMITED WARRANTY. EXCEPT WITH RESPECT TO REDISTRIBUTABLES, WHICH ARE PROVIDED "AS IS," WITHOUT WARRANTY OF ANY KIND, IOCOMP WARRANTS THAT THE SOFTWARE WILL PERFORM SUBSTANTIALLY IN ACCORDANCE WITH THE ACCOMPANYING';
  SLicenseAgreement86  = ' WRITTEN MATERIALS FOR A PERIOD OF THIRTY (30) DAYS FROM THE DATE OF RECEIPT. SOME STATES AND JURISDICTIONS DO NOT ALLOW LIMITATIONS OF DURATION OF AN IMPLIED WARRANTY, SO THE ABOVE LIMITATION MAY NOT APPLY TO YOU. TO THE';
  SLicenseAgreement87  = ' EXTENT ALLOWED BY APPLICABLE LAW, IMPLIED WARRANTIES ON THE SOFTWARE, IF ANY, ARE LIMITED TO THIRTY (30) DAYS.';
  SLicenseAgreement88  = 'CUSTOMER REMEDIES. IOCOMP''S AND ITS SUPPLIERS'' ENTIRE LIABILITY AND YOUR EXCLUSIVE REMEDY SHALL BE, AT IOCOMP''S OPTION, EITHER (A) RETURN OF THE PAID PRICE, OR (B) REPAIR OR REPLACEMENT OF THE SOFTWARE. PRODUCTS';
  SLicenseAgreement89  = ' PURCHASED OTHER THAN DIRECTLY FROM IOCOMP SHALL BE RETURNED THROUGH THE RESELLER FROM WHICH IT WAS PURCHASED. THIS LIMITED WARRANTY IS VOID IF FAILURE OF THE SOFTWARE HAS RESULTED FROM ACCIDENT, ABUSE, OR MISAPPLICATION.';
  SLicenseAgreement90  = ' ANY REPLACEMENT SOFTWARE WILL BE WARRANTED FOR THE REMAINDER OF THE ORIGINAL THIRTY (30) DAY PERIOD. OUTSIDE THE UNITED STATES, NEITHER THESE REMEDIES NOR ANY PRODUCT SUPPORT SERVICES OFFERED BY IOCOMP ARE AVAILABLE';
  SLicenseAgreement91  = ' WITHOUT PROOF OF PURCHASE FROM AN AUTHORIZED INTERNATIONAL SOURCE.';
  SLicenseAgreement92  = #13 + #10;
  SLicenseAgreement93  = 'NO OTHER WARRANTIES. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IOCOMP AND ITS SUPPLIERS DISCLAIM ALL OTHER WARRANTIES, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF';
  SLicenseAgreement94  = ' MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH REGARD TO THE SOFTWARE. THIS LIMITED WARRANTY GIVES YOU SPECIFIC LEGAL RIGHTS. YOU MAY HAVE OTHERS, WHICH VARY FROM STATE/JURISDICTION TO STATE/JURISDICTION.';
  SLicenseAgreement95  = #13 + #10;
  SLicenseAgreement96  = 'NO LIABILITIES FOR CONSEQUENTIAL DAMAGES. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL IOCOMP OR ITS SUPPLIERS BE LIABLE FOR ANY SPECIAL, INCIDENTAL, INDIRECT, OR CONSEQUENTIAL DAMAGES WHATSOEVER';
  SLicenseAgreement97  = ' (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR ANY OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF';
  SLicenseAgreement98  = ' IOCOMP HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. BECAUSE SOME STATES AND JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU.';
  SLicenseAgreement99  = #13 + #10;
  SLicenseAgreement100 = 'LICENSEE ACKNOWLEDGES THAT IT HAS READ AND UNDERSTANDS THIS AGREEMENT AND AGREES TO BE BOUND BY ITS TERMS. LICENSEE FURTHER AGREES THAT THIS AGREEMENT IS THE COMPLETE AND EXCLUSIVE STATEMENT OF THE AGREEMENT BETWEEN';
  SLicenseAgreement101 = ' LICENSEE AND LICENSOR, AND SUPERCEDES ANY PROPOSAL OR PRIOR AGREEMENT, ORAL OR WRITTEN, AND ANY OTHER COMMUNICATIONS RELATING TO THE SUBJECT MATER OF THIS AGREEMENT.';
implementation

end.
