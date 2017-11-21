
{$IFNDEF VER80}                                             {Delphi 1.0}
  {$DEFINE VERSION2}                                        {Delphi 2.0 and BCB 1 or higher}
{$ENDIF}

{$IFDEF VERSION2}
  {$IFNDEF VER90}                                           {Delphi 2.0}
    {$IFNDEF VER93}                                         {BCB 1.0}
      {$DEFINE VERSION3}                                    {Delphi 3.0 or BCB 3.0}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION3}
  {$IFNDEF VER100}                                          {Delphi 3}
    {$IFNDEF VER110}                                        {BCB 3}
      {$DEFINE VERSION4}                                    {Delphi 4.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION4}
  {$IFNDEF VER120}                                          {Delphi 4}
    {$IFNDEF VER125}                                        {BCB 4}
      {$DEFINE VERSION5}                                    {Delphi 5.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION5}
  {$IFNDEF VER130}                                          {Delphi 5}
    {$IFNDEF VER135}                                        {BCB 5}
      {$DEFINE VERSION6}                                    {Delphi 6.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION6}
  {$IFNDEF VER140}                                          {Delphi 6}
    {$IFNDEF VER145}                                        {BCB 6}
      {$DEFINE VERSION7}                                    {Delphi 7.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION7}
 {$IFNDEF VER150}                                           {Delphi 7}
     {$DEFINE VERSION9}                                     {Delphi 2005}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION9}
  {$IFNDEF VER170}                                          {Delphi 2005}
    {$DEFINE VERSION10}                                     {Delphi 2006}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION10}
  {$IFDEF VER185}
    {$DEFINE VERSION11}                                     {Delphi 2007}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER210}
  {$DEFINE VERSION14}                                       {Delphi 2010}
  {$DEFINE DELPHI2010}
{$ENDIF}

{$IFDEF VER220}
  {$DEFINE VERSION15}                                       {Delphi XE}
  {$DEFINE DELPHI2010}
  {$DEFINE DELPHIXE}
{$ENDIF}

{$IFDEF VER230}
  {$DEFINE VERSION16}                                       {Delphi XE2}
  {$DEFINE DELPHI2010}
  {$DEFINE DELPHIXE}
{$ENDIF}

{$IFDEF VER240}
  {$DEFINE VERSION17}                                       {Delphi XE3}
  {$DEFINE DELPHI2010}
  {$DEFINE DELPHIXE}
{$ENDIF}

{$IFDEF VER250}
  {$DEFINE VERSION18}                                       {Delphi XE4}
  {$DEFINE DELPHI2010}
  {$DEFINE DELPHIXE}
{$ENDIF}

{$IFDEF VER260}
  {$DEFINE VERSION19}                                     {Delphi XE5}
  {$DEFINE DELPHI2010}
  {$DEFINE DELPHIXE}
{$ENDIF}

{$IFDEF VERSION6}
  {$WARN SYMBOL_PLATFORM OFF}
  {$IFDEF VERSION7}
    {$WARN UNIT_PLATFORM OFF}
    {$WARN UNSAFE_CODE OFF}
    {$WARN UNSAFE_TYPE OFF}
    {$WARN UNSAFE_CAST OFF}
    {$WARN UNIT_DEPRECATED OFF}
    {$WARN SYMBOL_DEPRECATED OFF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION5}
  {$IFNDEF VERSION6}
    {$DEFINE VERSION5ONLY}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION7}
   {$IFNDEF VERSION9}
     {$DEFINE VERSION7ONLY}
   {$ENDIF}
{$ENDIF}
