<?php

/**
 * A class for reading Microsoft Excel Spreadsheets.
 *
 * Originally developed by Vadim Tkachenko under the name PHPExcelReader.
 * (http://sourceforge.net/projects/phpexcelreader)
 * Based on the Java version by Andy Khan (http://www.andykhan.com).  Now
 * maintained by David Sanders.  Reads only Biff 7 and Biff 8 formats.
 *
 * PHP versions 4 and 5
 *
 * LICENSE: This source file is subject to version 3.0 of the PHP license
 * that is available through the world-wide-web at the following URI:
 * http://www.php.net/license/3_0.txt.  If you did not receive a copy of
 * the PHP License and are unable to obtain it through the web, please
 * send a note to license@php.net so we can mail you a copy immediately.
 *
 * @category   Spreadsheet
 * @package    Spreadsheet_Excel_Reader
 * @author     Vadim Tkachenko <vt@apachephp.com>
 * @license    http://www.php.net/license/3_0.txt  PHP License 3.0
 * @version    CVS: $Id: reader.php 19 2007-03-13 12:42:41Z shangxiao $
 * @link       http://pear.php.net/package/Spreadsheet_Excel_Reader
 * @see        OLE, Spreadsheet_Excel_Writer
 * @updated    Marco Zordan: 2019-05-14
 */
/*
 * Place includes, constant defines and $_GLOBAL settings here.
 * Make sure they have appropriate docblocks to avoid phpDocumentor
 * construing they are documented by the page-level docblock.
 */

define('SPREADSHEET_EXCEL_READER_BIFF8', 0x600);
define('SPREADSHEET_EXCEL_READER_BIFF7', 0x500);
define('SPREADSHEET_EXCEL_READER_WORKBOOKGLOBALS', 0x5);
define('SPREADSHEET_EXCEL_READER_WORKSHEET', 0x10);

define('SPREADSHEET_EXCEL_READER_TYPE_BOF', 0x809);
define('SPREADSHEET_EXCEL_READER_TYPE_EOF', 0x0a);
define('SPREADSHEET_EXCEL_READER_TYPE_BOUNDSHEET', 0x85);
define('SPREADSHEET_EXCEL_READER_TYPE_DIMENSION', 0x200);
define('SPREADSHEET_EXCEL_READER_TYPE_ROW', 0x208);
define('SPREADSHEET_EXCEL_READER_TYPE_DBCELL', 0xd7);
define('SPREADSHEET_EXCEL_READER_TYPE_FILEPASS', 0x2f);
define('SPREADSHEET_EXCEL_READER_TYPE_NOTE', 0x1c);
define('SPREADSHEET_EXCEL_READER_TYPE_TXO', 0x1b6);
define('SPREADSHEET_EXCEL_READER_TYPE_RK', 0x7e);
define('SPREADSHEET_EXCEL_READER_TYPE_RK2', 0x27e);
define('SPREADSHEET_EXCEL_READER_TYPE_MULRK', 0xbd);
define('SPREADSHEET_EXCEL_READER_TYPE_MULBLANK', 0xbe);
define('SPREADSHEET_EXCEL_READER_TYPE_INDEX', 0x20b);
define('SPREADSHEET_EXCEL_READER_TYPE_SST', 0xfc);
define('SPREADSHEET_EXCEL_READER_TYPE_EXTSST', 0xff);
define('SPREADSHEET_EXCEL_READER_TYPE_CONTINUE', 0x3c);
define('SPREADSHEET_EXCEL_READER_TYPE_LABEL', 0x204);
define('SPREADSHEET_EXCEL_READER_TYPE_LABELSST', 0xfd);
define('SPREADSHEET_EXCEL_READER_TYPE_NUMBER', 0x203);
define('SPREADSHEET_EXCEL_READER_TYPE_NAME', 0x18);
define('SPREADSHEET_EXCEL_READER_TYPE_ARRAY', 0x221);
define('SPREADSHEET_EXCEL_READER_TYPE_STRING', 0x207);
define('SPREADSHEET_EXCEL_READER_TYPE_FORMULA', 0x406);
define('SPREADSHEET_EXCEL_READER_TYPE_FORMULA2', 0x6);
define('SPREADSHEET_EXCEL_READER_TYPE_FORMAT', 0x41e);
define('SPREADSHEET_EXCEL_READER_TYPE_XF', 0xe0);
define('SPREADSHEET_EXCEL_READER_TYPE_BOOLERR', 0x205);
define('SPREADSHEET_EXCEL_READER_TYPE_UNKNOWN', 0xffff);
define('SPREADSHEET_EXCEL_READER_TYPE_NINETEENFOUR', 0x22);
define('SPREADSHEET_EXCEL_READER_TYPE_MERGEDCELLS', 0xE5);

define('SPREADSHEET_EXCEL_READER_UTCOFFSETDAYS', 25569);
define('SPREADSHEET_EXCEL_READER_UTCOFFSETDAYS1904', 24107);
define('SPREADSHEET_EXCEL_READER_MSINADAY', 86400);
//define('SPREADSHEET_EXCEL_READER_MSINADAY', 24 * 60 * 60);
//define('SPREADSHEET_EXCEL_READER_DEF_NUM_FORMAT', "%.2f");
define('SPREADSHEET_EXCEL_READER_DEF_NUM_FORMAT', "%s");


define('NUM_BIG_BLOCK_DEPOT_BLOCKS_POS', 0x2c);
define('SMALL_BLOCK_DEPOT_BLOCK_POS', 0x3c);
define('ROOT_START_BLOCK_POS', 0x30);
define('BIG_BLOCK_SIZE', 0x200);
define('SMALL_BLOCK_SIZE', 0x40);
define('EXTENSION_BLOCK_POS', 0x44);
define('NUM_EXTENSION_BLOCK_POS', 0x48);
define('PROPERTY_STORAGE_BLOCK_SIZE', 0x80);
define('BIG_BLOCK_DEPOT_BLOCKS_POS', 0x4c);
define('SMALL_BLOCK_THRESHOLD', 0x1000);
// property storage offsets
define('SIZE_OF_NAME_POS', 0x40);
define('TYPE_POS', 0x42);
define('START_BLOCK_POS', 0x74);
define('SIZE_POS', 0x78);
define('IDENTIFIER_OLE', pack("CCCCCCCC", 0xd0, 0xcf, 0x11, 0xe0, 0xa1, 0xb1, 0x1a, 0xe1));
