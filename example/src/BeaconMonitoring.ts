import { NativeModules } from 'react-native';

const { BeaconMonitoring } = NativeModules;

export const requestPermissions = async () => {
  try {
    const result = await BeaconMonitoring.requestPermissions();
    console.log(result);
  } catch (error) {
    console.error(error);
  }
};

export const startMonitoring = async (uuid: string, identifier: string) => {
  try {
    const result = await BeaconMonitoring.startMonitoring(uuid, identifier);
    console.log(result);
  } catch (error) {
    console.error(error);
  }
};

export const stopMonitoring = async () => {
  try {
    const result = await BeaconMonitoring.stopMonitoring();
    console.log(result);
  } catch (error) {
    console.error(error);
  }
};
