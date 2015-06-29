function [manifest] = write_manifest(tracker)
% write_manifest Write a manifest file for the tracker
%
% Write a manifest file for the tracker. The manifest file contains some system
% statistics that can be used for debugging and analysis.
%
% Input:
% - tracker: Tracker structure.
%
% Output:
% - manifest: Full path to the manifest file that is located in tracker result directory.

mkpath(tracker.directory);

manifest = fullfile(tracker.directory, 'manifest.txt');

[platform_str, platform_maxsize, platform_endian] = computer();

if is_octave()
    environment = 'octave';
else
    environment = 'matlab';
end;

if tracker.trax
    protocol = 'trax';
else
    protocol = 'file';
end;

environment_version = version();

fid = fopen(manifest, 'w');

version = toolkit_version();

fprintf(fid, 'toolkit.version=%d.%d\n', version.major, version.minor);
fprintf(fid, 'tracker.identifier=%s\n', tracker.identifier);
fprintf(fid, 'tracker.protocol=%s\n', protocol);
fprintf(fid, 'timestamp=%s\n', datestr(now, 31));
fprintf(fid, 'platfrom=%s\n', platform_str);
fprintf(fid, 'platfrom.maxsize=%f\n', platform_maxsize);
fprintf(fid, 'platfrom.endian=%s\n', platform_endian);
fprintf(fid, 'environment=%s\n', environment);
fprintf(fid, 'environment.version=%s\n', environment_version);

fclose(fid);
